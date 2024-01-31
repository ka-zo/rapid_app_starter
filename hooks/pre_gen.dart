import 'dart:io';

import 'package:mason/mason.dart';

import 'licenses.dart';
import 'utils.dart' as utils;

Future<void> run(HookContext context) async {
  const List<String> flutterPackages = [
    'flutter_localization:^0.2.0',
    'flutter_native_splash: ^2.3.10',
    'logger:^2.0.2+1',
    'package_info_plus:^5.0.1',
    'shared_preferences:^2.2.2',
  ];

  context.vars['license'] = licenses[context.vars['license']];

  _includeAssetsInPubspec();

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

void _includeAssetsInPubspec() {
  String content = File('pubspec.yaml').readAsStringSync();
  if (!content.contains('- android/app/src/main/res/mipmap-xxhdpi/')) {
    content = content.replaceFirst(RegExp('^flutter:\$', multiLine: true),
"""
flutter:
  
  # Do not forget to include here the path to your image for the splash screen
  assets:
    - android/app/src/main/res/mipmap-xxhdpi/
    - assets/
""");
    File('pubspec.yaml').writeAsStringSync(content);
  }
}

void _setFlutterMinSdkLevel({required HookContext context, required int minSdkVersion}) {
  const String buildGradleFile = './android/app/build.gradle';
  final String now = DateTime.now().toLocal().toIso8601String().replaceAll(':', '-').substring(0,19);
  final String buildGradleFileBak = "./android/app/$now.build.gradle";
  const String localPropertiesFile = './android/local.properties';

  String content = File(buildGradleFile).readAsStringSync();
  // Backing up gradle file.
  context.logger.info("Backing up $buildGradleFile to $buildGradleFileBak");
  File(buildGradleFileBak).writeAsStringSync(content);
  // Modifying gradle file
  context.logger.info("Modifying $buildGradleFile to read minSdkVersion from $localPropertiesFile");
  content = content.replaceFirst(RegExp(r'minSdkVersion(.*)$', multiLine: true, dotAll: false), 'minSdkVersion localProperties.getProperty(\'flutter.minSdkVersion\').toInteger()');
  File(buildGradleFile).writeAsStringSync(content);

  content = File(localPropertiesFile).readAsStringSync();
  final String newProperty = "flutter.minSdkVersion=$minSdkVersion";
  context.logger.info("Setting minSdkVersion to $minSdkVersion in $localPropertiesFile");
  if (content.contains('flutter.minSdkVersion')) {
    content = content.replaceFirst(RegExp('^flutter.minSdkVersion(.*)', multiLine: true, dotAll: true), newProperty);
    File(localPropertiesFile).writeAsStringSync(content);
  } else {
    File(localPropertiesFile).writeAsStringSync("\n$newProperty", mode:FileMode.append);
  }
}
