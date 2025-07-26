import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'licenses.dart';
import 'utils.dart' as utils;

Future<void> run(HookContext context) async {
  const String localPropertiesFile = './android/local.properties';
  const String buildGradleKts = './android/app/build.gradle.kts';

  List<String> flutterPackages = [
    'flutter_localization:^0.3.3',
    'flutter_native_splash:^2.4.6',
    'logger:^2.6.0',
    'package_info_plus:^8.3.0',
    'shared_preferences:^2.5.3',
  ];

  if (context.vars['use_authentication']) {
    flutterPackages += [
      'firebase_core:^3.15.1',
      'firebase_auth: ^5.6.2',
      'firebase_ui_auth:^1.17.0',
      'google_sign_in:^6.2.1',
      'firebase_ui_oauth_google:^1.4.2',
      'firebase_ui_localizations:^1.14.0',
    ];
    final Map fontsSocialIcons = {
      'family': 'SocialIcons',
      'fonts': [
        {'asset': 'packages/firebase_ui_auth/fonts/SocialIcons.ttf'}
      ]
    };
    _addFontsToPubspec(context: context, fonts: fontsSocialIcons);
  }

  final Set<String> assets = {
    'android/app/src/main/res/mipmap-xxhdpi/',
    'assets/',
  };
  _addAssetsToPubspec(context: context, assets: assets);

  context.vars['license'] = licenses[context.vars['license']];

  _setKeyInFile(
      context: context,
      filePath: localPropertiesFile,
      key: "minSdkVersion",
      value: 23,
      appendIfMissing: true);
  _setKeyInFile(
      context: context, filePath: buildGradleKts, key: "minSdk", value: 23);

  _setKeyInFile(
      context: context,
      filePath: buildGradleKts,
      key: "ndkVersion",
      value: "27.0.12077973");

  final progress = context.logger.progress("Installing packages...");
  for (String e in flutterPackages) {
    utils.executeSync(
        context: context,
        executable: 'flutter',
        parameters: ['pub', 'add', e],
        verbose: context.vars['verbose']);
  }
  utils.executeSync(
      context: context,
      executable: 'flutter',
      parameters: ['pub', 'get'],
      verbose: context.vars['verbose']);

  progress.complete();
}

void _addAssetsToPubspec(
    {required HookContext context, required Set<String> assets}) {
  final String content = File('pubspec.yaml').readAsStringSync();
  final pubspec = YamlEditor(content);

  try {
    final YamlList assetsNode =
        pubspec.parseAt(['flutter', 'assets']) as YamlList;
    final assetsList = assetsNode.toSet().union(assets).toList();
    pubspec.update(['flutter', 'assets'], assetsList);
    context.logger.info("Assets are added to pubspec.yaml.");
  } on ArgumentError catch (e) {
//      context.logger.info(e);
    context.logger
        .info('Creating flutter / assets path. It does not yet exist.');
    pubspec.update(['flutter', 'assets'], assets.toList());
  }

  File('pubspec.yaml').writeAsStringSync(pubspec.toString());
}

void _addFontsToPubspec({required HookContext context, required Map fonts}) {
  final String content = File('pubspec.yaml').readAsStringSync();
  final pubspec = YamlEditor(content);

  try {
    final YamlList fontsNode =
        pubspec.parseAt(['flutter', 'fonts']) as YamlList;
    bool hasFonts = false;
    fontsNode.forEach((item) {
      if (item['family'] == fonts['family']) {
        hasFonts = true;
      }
    });
    if (!hasFonts) {
      pubspec.prependToList(['flutter', 'fonts'], fonts);
      context.logger.info("Font ${fonts['family']} is added to pubspec.yaml.");
    } else {
      context.logger
          .info("Font ${fonts['family']} is already in pubspec.yaml.");
    }
  } on ArgumentError catch (e) {
//      context.logger.info(e);
    context.logger
        .info('Creating flutter / fonts path. It does not yet exist.');
    context.logger.info("Font ${fonts['family']} is added to pubspec.yaml.");
    pubspec.update(['flutter', 'fonts'], [fonts]);
  }

  File('pubspec.yaml').writeAsStringSync(pubspec.toString());
}

void _setKeyInFile({
  required HookContext context,
  required String filePath,
  required String key,
  required Object value,
  bool appendIfMissing = false,
}) {
  final formattedValue = value is String ? '"$value"' : value;

  try {
    if (!File(filePath).existsSync()) {
      print('Error: $filePath does not exist.');
      return;
    }

    String content = File(filePath).readAsStringSync();

    final RegExp regex = RegExp('^([ \\t]*$key\\s*=\\s*).*', multiLine: true);

    // Replace all occurrences where the key is found.
    // The replacement string combines the captured prefix (Group 1, e.g., "  setting_name=")
    // with the new value.
    final String modifiedContent = content.replaceAllMapped(regex, (match) {
      // match.group(1) contains the prefix (leading whitespace + key=).
      // We use '!' because if a match occurs, group(1) will always be non-null.
      return '${match.group(1)!}$formattedValue';
    });

    if (regex.hasMatch(content)) {
      File(filePath).writeAsStringSync(modifiedContent);
      context.logger.info('$key updated to $value in $filePath');
    } else if (appendIfMissing) {
      File(filePath).writeAsStringSync(
        content + '\n$key=$formattedValue',
      );
      context.logger
          .info('$key appended as $key = $formattedValue in $filePath');
    } else {
      context.logger.info('$key not found. No update performed in $filePath.');
    }
  } catch (e) {
    context.logger.info('Error updating $key in $filePath: $e');
  }
}
