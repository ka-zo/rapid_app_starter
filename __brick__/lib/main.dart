import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'globals.dart' as globals;
import 'languages.dart';
import 'theme_data.dart';
import 'screen_eula.dart';
import 'screen_main.dart';
import 'screen_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            title: 'OrbitWise',
            initialRoute: '/',
            routes: {
              '/': (context) => const MySplashScreen(),
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
