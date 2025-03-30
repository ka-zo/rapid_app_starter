import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'licenses.dart';
import 'utils.dart' as utils;

Future<void> run(HookContext context) async {
  List<String> flutterPackages = [
    'flutter_localization:^0.2.0',
    'flutter_native_splash:^2.3.10',
    'logger:^2.0.2+1',
    'package_info_plus:^5.0.1',
    'shared_preferences:^2.2.2',
  ];

  if (context.vars['use_authentication']) {
    flutterPackages += [
      'firebase_core:^2.25.4',
      'firebase_auth: ^4.17.4',
      'firebase_ui_auth:^1.13.0',
      'google_sign_in:^6.2.1',
      'firebase_ui_oauth_google:^1.3.0',
      'firebase_ui_localizations:^1.10.2',
    ];
    final Map fontsSocialIcons = {
        'family': 'SocialIcons',
        'fonts': [{
            'asset': 'packages/firebase_ui_auth/fonts/SocialIcons.ttf'
        }]
    };
    _addFontsToPubspec(context: context, fonts: fontsSocialIcons);
  }

  final Set<String> assets = {
      'android/app/src/main/res/mipmap-xxhdpi/',
      'assets/',
  };
  _addAssetsToPubspec(context: context, assets: assets);

  context.vars['license'] = licenses[context.vars['license']];

  _setFlutterMinSdkLevel(context: context, minSdkVersion: 21);

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

void _addAssetsToPubspec({
  required HookContext context,
  required Set<String> assets
}) {
  final String content = File('pubspec.yaml').readAsStringSync();
  final pubspec = YamlEditor(content);

  try {
      final YamlList assetsNode = pubspec.parseAt(['flutter', 'assets']) as YamlList;
      final assetsList = assetsNode.toSet().union(assets).toList();
      pubspec.update(['flutter', 'assets'], assetsList);
      context.logger.info("Assets are added to pubspec.yaml.");
  } on ArgumentError catch (e) {
//      context.logger.info(e);
      context.logger.info('Creating flutter / assets path. It does not yet exist.');
      pubspec.update(['flutter', 'assets'], assets.toList());
  }

  File('pubspec.yaml').writeAsStringSync(pubspec.toString());
}

void _addFontsToPubspec({
  required HookContext context,
  required Map fonts
}) {
  final String content = File('pubspec.yaml').readAsStringSync();
  final pubspec = YamlEditor(content);

  try {
      final YamlList fontsNode = pubspec.parseAt(['flutter', 'fonts']) as YamlList;
      bool hasFonts = false;
      fontsNode.forEach(
          (item) {
              if (item['family'] == fonts['family']) {
                  hasFonts = true;
              }
          }
      );
      if (!hasFonts) {
          pubspec.prependToList(['flutter', 'fonts'], fonts);
          context.logger.info("Font ${fonts['family']} is added to pubspec.yaml.");
      } else {
          context.logger.info("Font ${fonts['family']} is already in pubspec.yaml.");
      }
  } on ArgumentError catch (e) {
//      context.logger.info(e);
      context.logger.info('Creating flutter / fonts path. It does not yet exist.');
      context.logger.info("Font ${fonts['family']} is added to pubspec.yaml.");
      pubspec.update(['flutter', 'fonts'], [fonts]);
  }

  File('pubspec.yaml').writeAsStringSync(pubspec.toString());
}

void _setFlutterMinSdkLevel({required HookContext context, required int minSdkVersion}) {
  const String localPropertiesFile = './android/local.properties';

  String content = File(localPropertiesFile).readAsStringSync();
  final String newProperty = "flutter.minSdkVersion=$minSdkVersion";
  context.logger.info("Setting minSdkVersion to $minSdkVersion in $localPropertiesFile");
  if (content.contains('flutter.minSdkVersion')) {
    content = content.replaceFirst(RegExp('^flutter.minSdkVersion(.*)', multiLine: true, dotAll: true), newProperty);
    File(localPropertiesFile).writeAsStringSync(content);
  } else {
    File(localPropertiesFile).writeAsStringSync("\n$newProperty", mode:FileMode.append);
  }
}
