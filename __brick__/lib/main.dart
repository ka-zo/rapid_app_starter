import 'dart:io';

{{#use_authentication}}
import 'package:firebase_core/firebase_core.dart';
{{/use_authentication}}
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
{{#use_authentication}}
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
{{/use_authentication}}
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'eula.dart' as eula;
{{#use_authentication}}
import 'firebase_options.dart';
{{/use_authentication}}
import 'globals.dart' as globals;
import 'languages.dart';
import 'preferences.dart' as preferences;
import 'screen_eula.dart';
{{#use_authentication}}
import 'screen_login.dart';
{{/use_authentication}}
import 'screen_main.dart';
import 'theme_data.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
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
  Locale currentLocale = const Locale('en');

  // the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    currentLocale = locale ?? const Locale('en');
    setState(() {});
  }

  void _initLocalization() {
    globals.localization.init(
      mapLocales: [
        MapLocale('en', AppLocale.en, countryCode: 'US',fontFamily: 'Font EN',),
        MapLocale('de', AppLocale.de, countryCode: 'DE',fontFamily: 'Font DE',),
        MapLocale('es', AppLocale.es, countryCode: 'ES',fontFamily: 'Font ES',),
        MapLocale('hu', AppLocale.hu, countryCode: 'HU',fontFamily: 'Font HU',),
        MapLocale('cs', AppLocale.cs, countryCode: 'CS',fontFamily: 'Font CS',),
        MapLocale('pl', AppLocale.pl, countryCode: 'PL',fontFamily: 'Font PL',),
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
              {{#use_authentication}}
              '/login': (context) => const LoginScreen(),
              {{/use_authentication}}
              '/eula': (context) => const AcceptEulaScreen(),
              '/home': (context) => const MyHomePage(),
            },
            theme: currentTheme.colorSchemeSet.light,
            darkTheme: currentTheme.colorSchemeSet.dark,
            themeMode: currentTheme.brightness,
            supportedLocales: globals.localization.supportedLocales,
            locale: currentLocale,
            {{#use_authentication}}
            localizationsDelegates: globals.localization.localizationsDelegates.toList() + [
              FirebaseUILocalizations.delegate,
            ],
            {{/use_authentication}}
            {{^use_authentication}}
            localizationsDelegates: globals.localization.localizationsDelegates,
            {{/use_authentication}}
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
    globals.logger.i("Supported locales: ${globals.localization.supportedLocales}");
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

    {{#use_authentication}}
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    {{/use_authentication}}
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
            {{#use_authentication}}
            ? Navigator.pushReplacementNamed(context, '/login')
            {{/use_authentication}}
            {{^use_authentication}}
            ? Navigator.pushReplacementNamed(context, '/home')
            {{/use_authentication}}
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
