import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'eula.dart' as eula;
import 'globals.dart' as globals;
import 'languages.dart';
import 'preferences.dart' as preferences;
import 'screen_eula.dart';
import 'screen_main.dart';
import 'theme_data.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  // This ValueNotifier should be used from all screens, when the theme should be changed.
  static final ValueNotifier<BrightnessSelector> themeNotifier = ValueNotifier(
      BrightnessSelector(colorSchemeSet: ColorSchemeDefinition.orange)
  );

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState  extends State<MyApp> {

  // the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  Future<void> _initLocalization() async {
    await globals.localization.init(
      mapLocales: [
        MapLocale('en', AppLocale.en, countryCode: 'US',fontFamily: 'Font EN',),
        MapLocale('de', AppLocale.de, countryCode: 'DE',fontFamily: 'Font DE',),
        MapLocale('es', AppLocale.es, countryCode: 'ES',fontFamily: 'Font ES',),
        MapLocale('hu', AppLocale.hu, countryCode: 'HU',fontFamily: 'Font HU',),
      ],
      initLanguageCode: 'en',
    );
    globals.localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  @override
  void initState() {
    super.initState();
    _initLocalization();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: MyApp.themeNotifier,
        builder: (context, BrightnessSelector currentTheme, _) {
          return MaterialApp(
            title: eula.appName,
            initialRoute: '/',
            routes: {
              '/': (context) => const InitializeAppScreen(),
              '/eula': (context) => const AcceptEulaScreen(),
              '/home': (context) => const MyHomePage(),
            },
            theme: currentTheme.colorSchemeSet.light,
            darkTheme: currentTheme.colorSchemeSet.dark,
            themeMode: currentTheme.brightness,
            supportedLocales: globals.localization.supportedLocales,
            localizationsDelegates: globals.localization.localizationsDelegates,
          );
        }
    );
  }
}

class InitializeAppScreen extends StatefulWidget {
  const InitializeAppScreen({super.key});
  // This ValueNotifier should be used from all screens, when the theme should be changed.
  @override
  State<InitializeAppScreen> createState() => _InitializeAppScreenState();
}

class _InitializeAppScreenState  extends State<InitializeAppScreen> {
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
    // TODO: implement initState
    super.initState();
    _startAsyncFunction().then((_) {
      Future.delayed(const Duration(milliseconds: 800), ()
      {
        FlutterNativeSplash.remove();
        _eulaAccepted
            ? Navigator.pushReplacementNamed(context, '/home')
            : Navigator.pushReplacementNamed(context, '/eula');
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Initializing the app ...'),
          ),
        ],
      ),
    );
  }
}