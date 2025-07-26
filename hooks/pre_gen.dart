import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'licenses.dart';
import 'utils.dart' as utils;

/// The main entry point for the Mason pre-gen hook.
/// Sets up project files, updates Gradle and pubspec, installs packages, etc.
///
/// Parameters:
/// - [context]: The Mason HookContext containing variables and logger.
///
/// Returns:
/// - [Future<void>]: Completes when all setup steps are finished.
Future<void> run(HookContext context) async {
  const String localPropertiesFile = './android/local.properties';
  const String buildGradleKts = './android/app/build.gradle.kts';

  // List of required Flutter packages for the project.
  List<String> flutterPackages = [
    'flutter_localization:^0.3.3',
    'flutter_native_splash:^2.4.6',
    'logger:^2.6.0',
    'package_info_plus:^8.3.0',
    'shared_preferences:^2.5.3',
  ];

  // If authentication is enabled, add Firebase and related packages.
  if (context.vars['use_authentication']) {
    flutterPackages += [
      'firebase_core:^3.15.1',
      'firebase_auth: ^5.6.2',
      'firebase_ui_auth:^1.17.0',
      'google_sign_in:^6.2.1',
      'firebase_ui_oauth_google:^1.4.2',
      'firebase_ui_localizations:^1.14.0',
    ];
    // Add SocialIcons font for Firebase UI Auth.
    final Map fontsSocialIcons = {
      'family': 'SocialIcons',
      'fonts': [
        {'asset': 'packages/firebase_ui_auth/fonts/SocialIcons.ttf'}
      ]
    };
    _addFontsToPubspec(context: context, fonts: fontsSocialIcons);
  }

  // Set of asset directories to add to pubspec.yaml.
  final Set<String> assets = {
    'android/app/src/main/res/mipmap-xxhdpi/',
    'assets/',
  };
  _addAssetsToPubspec(context: context, assets: assets);

  // Set license variable for the context.
  context.vars['license'] = licenses[context.vars['license']];

  // Update or append minSdkVersion in local.properties.
  _setKeyInFile(
      context: context,
      filePath: localPropertiesFile,
      key: "minSdkVersion",
      value: 23,
      appendIfMissing: true);
  // Update minSdk in build.gradle.kts.
  _setKeyInFile(
      context: context, filePath: buildGradleKts, key: "minSdk", value: 23);

  // Update ndkVersion in build.gradle.kts.
  _setKeyInFile(
      context: context,
      filePath: buildGradleKts,
      key: "ndkVersion",
      value: "27.0.12077973");

  // Show progress while installing packages.
  final progress = context.logger.progress("Installing packages...");
  for (String e in flutterPackages) {
    // Add each package using flutter pub add.
    utils.executeSync(
        context: context,
        executable: 'flutter',
        parameters: ['pub', 'add', e],
        verbose: context.vars['verbose']);
  }
  // Run flutter pub get to fetch all dependencies.
  utils.executeSync(
      context: context,
      executable: 'flutter',
      parameters: ['pub', 'get'],
      verbose: context.vars['verbose']);

  progress.complete();
}

/// Adds asset directories to pubspec.yaml under flutter/assets.
/// If the assets node doesn't exist, it creates it.
///
/// Parameters:
/// - [context]: The Mason HookContext for logging and context.
/// - [assets]: A set of asset directory strings to add.
///
/// Returns:
/// - [void]: Updates pubspec.yaml in place.
void _addAssetsToPubspec(
    {required HookContext context, required Set<String> assets}) {
  final String content = File('pubspec.yaml').readAsStringSync();
  final pubspec = YamlEditor(content);

  try {
    // Try to parse existing assets node.
    final YamlList assetsNode =
        pubspec.parseAt(['flutter', 'assets']) as YamlList;
    // Merge existing assets with new ones.
    final assetsList = assetsNode.toSet().union(assets).toList();
    pubspec.update(['flutter', 'assets'], assetsList);
    context.logger.info("Assets are added to pubspec.yaml.");
  } on ArgumentError catch (e) {
    // If assets node doesn't exist, create it.
    context.logger
        .info('Creating flutter / assets path. It does not yet exist.');
    pubspec.update(['flutter', 'assets'], assets.toList());
  }

  // Write changes back to pubspec.yaml.
  File('pubspec.yaml').writeAsStringSync(pubspec.toString());
}

/// Adds a font entry to pubspec.yaml under flutter/fonts.
/// If the fonts node doesn't exist, it creates it.
///
/// Parameters:
/// - [context]: The Mason HookContext for logging and context.
/// - [fonts]: A map describing the font family and font assets.
///
/// Returns:
/// - [void]: Updates pubspec.yaml in place.
void _addFontsToPubspec({required HookContext context, required Map fonts}) {
  final String content = File('pubspec.yaml').readAsStringSync();
  final pubspec = YamlEditor(content);

  try {
    // Try to parse existing fonts node.
    final YamlList fontsNode =
        pubspec.parseAt(['flutter', 'fonts']) as YamlList;
    bool hasFonts = false;
    // Check if the font family already exists.
    fontsNode.forEach((item) {
      if (item['family'] == fonts['family']) {
        hasFonts = true;
      }
    });
    if (!hasFonts) {
      // Prepend new font to the fonts list.
      pubspec.prependToList(['flutter', 'fonts'], fonts);
      context.logger.info("Font ${fonts['family']} is added to pubspec.yaml.");
    } else {
      context.logger
          .info("Font ${fonts['family']} is already in pubspec.yaml.");
    }
  } on ArgumentError catch (e) {
    // If fonts node doesn't exist, create it.
    context.logger
        .info('Creating flutter / fonts path. It does not yet exist.');
    context.logger.info("Font ${fonts['family']} is added to pubspec.yaml.");
    pubspec.update(['flutter', 'fonts'], [fonts]);
  }

  // Write changes back to pubspec.yaml.
  File('pubspec.yaml').writeAsStringSync(pubspec.toString());
}

/// Updates or appends a key-value pair in a file.
/// If the key exists, replaces its value. If not and appendIfMissing is true, appends the key-value line.
/// Handles both int and string values (quotes added for strings).
///
/// Parameters:
/// - [context]: The Mason HookContext for logging and context.
/// - [filePath]: The path to the file to update.
/// - [key]: The property name to search for and update.
/// - [value]: The new value to set (int or String; String values are quoted).
/// - [appendIfMissing]: If true, appends the key-value line if the key is not found.
///
/// Returns:
/// - [void]: Updates the file in place.
void _setKeyInFile({
  required HookContext context,
  required String filePath,
  required String key,
  required Object value,
  bool appendIfMissing = false,
}) {
  final formattedValue = value is String ? '"$value"' : value;

  try {
    // Check if the file exists.
    if (!File(filePath).existsSync()) {
      print('Error: $filePath does not exist.');
      return;
    }

    String content = File(filePath).readAsStringSync();

    // Regex to find the key in the file.
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
      // If key found, update its value.
      File(filePath).writeAsStringSync(modifiedContent);
      context.logger.info('$key updated to $value in $filePath');
    } else if (appendIfMissing) {
      // If key not found and appendIfMissing is true, append key-value to end of file.
      File(filePath).writeAsStringSync(
        content + '\n$key=$formattedValue',
      );
      context.logger
          .info('$key appended as $key = $formattedValue in $filePath');
    } else {
      // If key not found and not appending, log no update.
      context.logger.info('$key not found. No update performed in $filePath.');
    }
  } catch (e) {
    // Log any errors encountered.
    context.logger.info('Error updating $key in $filePath: $e');
  }
}
