import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'eula.dart' as eula;
import 'globals.dart' as globals;
import 'preferences.dart' as preferences;
import 'theme_data.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  late final String _languageCode;
  late final bool _eulaAccepted;


  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      globals.packageInfo = info;
    });
  }

  Future<void> _startAsyncFunction() async {
    // This is where you can perform any asynchronous operations
    // before the fade-in animation begins.
    // You can add your logic here.
    await _initPackageInfo();

    preferences.prefs = await SharedPreferences.getInstance();
    globals.logger.i("System version: ${Platform.version}");
    globals.logger.i("System OS: ${Platform.operatingSystem}");
    globals.logger.i("System OS version: ${Platform.operatingSystemVersion}");
    globals.logger.i("System locale: ${Platform.localeName}");
    final String? tempLanguageCode = preferences.getLanguageCode();
    globals.logger.i("Loaded languageCode: ${tempLanguageCode ?? 'language code is not yet saved.'}");

    if (tempLanguageCode == null) {
      String platformLanguageCode = Platform.localeName.substring(0, 2);
      if (globals.localization.supportedLanguageCodes.contains(platformLanguageCode)) {
        _languageCode = platformLanguageCode;
        globals.logger.i("Platform languageCode $platformLanguageCode is supported by ${eula.appName}.");
      } else {
        _languageCode = 'en';
        globals.logger.i("Platform languageCode $platformLanguageCode is NOT supported by ${eula.appName}.");
      }
      await preferences.setLanguageCode(_languageCode);
      globals.logger.i("Automatically saved and set languageCode: $_languageCode");
    } else {
      _languageCode = tempLanguageCode;
    }
    globals.localization.translate(_languageCode);
    _eulaAccepted = preferences.getEulaAccepted() ?? false;
    globals.logger.i("User already accepted EULA: $_eulaAccepted");


    final actualColorSchemeSet = await ColorSchemeDefinition.actualColorSchemeSet;
    final actualBrightness = await ColorSchemeDefinition.actualBrightness;
    MyApp.themeNotifier.value = BrightnessSelector(colorSchemeSet: actualColorSchemeSet, brightness: actualBrightness);
  }

  @override
  void initState() {
    super.initState();

    _startAsyncFunction().then((_) {
      Future.delayed(const Duration(milliseconds: 800), ()
      {
        _eulaAccepted
            ? Navigator.pushReplacementNamed(context, '/home')
            : Navigator.pushReplacementNamed(context, '/eula');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 800),
            child: Image.asset("android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png"),
          ),
        ),
      )
    );
  }
}
