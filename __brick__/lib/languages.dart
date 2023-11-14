import 'eula.dart' as eula;

/// Dictionary for all supported languages (currently English, German and Hungarian).
/// You need to manually add a dictionary for each new language and you need to
/// manually extend the dictionary with new words for each language.
mixin AppLocale {
  static const String about = 'about';
  static const String accept = 'accept';
  static const String appDescription = 'App description';
  static const String blue = 'blue';
  static const String brightness = 'brightness';
  static const String colorScheme = 'Color scheme';
  static const String dark = 'dark';
  static const String decline = 'decline';
  static const String eulaBody = 'eula body';
  static const String eulaTitle = 'eula';
  static const String exampleText = 'example text';
  static const String green = 'green';
  static const String language = 'language';
  static const String license = 'license';
  static const String light = 'light';
  static const String mainPage = 'Main page';
  static const String menu = 'menu';
  static const String orange = 'orange';
  static const String purple = 'purple';
  static const String satellite = 'satellite';
  static const String selectLanguage = 'Select language';
  static const String system = 'system';
  static const String theme = 'theme';
  static const String version = 'version';
  static const String viewLicenses = 'View licenses';

  static final Map<String, dynamic> en = {
    about: 'About',
    accept: 'Accept',
    appDescription: 'Accelerate app development effortlessly! This Flutter package offers a powerful starting template featuring Material 3 support, seamless internationalization, easy license handling, and flexible themes. With built-in state management and a navigation drawer for enhanced user experience, kickstart your project and watch your app come to life with ease and finesse.',
    blue: 'Blue',
    brightness: 'Brightness',
    colorScheme: 'Color scheme',
    dark: 'Dark',
    decline: 'Decline',
    eulaBody: eula.License.en,
    eulaTitle: 'End-User License Agreement',
    exampleText: 'This is an example text.',
    green: 'Green',
    language: 'Language',
    license: 'License',
    light: 'Light',
    mainPage: 'Main page',
    menu: 'Menu',
    orange: 'Orange',
    purple: 'Purple',
    satellite: 'satellite',
    selectLanguage: 'Select language',
    system: 'System',
    theme: 'Theme',
    version: 'Version',
    viewLicenses: 'View licenses',
  };
  static final Map<String, dynamic> de = {
    about: 'Impressum',
    accept: 'Zustimmen',
    appDescription: 'Beschleunigen Sie die App-Entwicklung mühelos! Dieses Flutter-Paket bietet eine leistungsstarke Ausgangsvorlage mit Material 3-Unterstützung, nahtloser Internationalisierung, einfacher Lizenzverwaltung und flexiblen Designs. Mit integriertem Zustandsmanagement und einer Navigationsleiste für eine verbesserte Benutzererfahrung starten Sie Ihr Projekt und sehen Sie zu, wie Ihre App mit Leichtigkeit und Finesse zum Leben erweckt wird.',
    blue: 'Blau',
    brightness: 'Helligkeit',
    colorScheme: 'Farbzusammensetzung',
    dark: 'Dunkel',
    decline: 'Ablehnen',
    eulaBody: eula.License.de,
    eulaTitle: 'Endbenutzer-Lizenzvereinbarung',
    exampleText: 'Dies ist ein Beispieltext.',
    green: 'Grün',
    language: 'Sprache',
    license: 'Lizenz',
    light: 'Hell',
    mainPage: 'Hauptseite',
    menu: 'Menüs',
    orange: 'Orange',
    purple: 'Lila',
    satellite: 'Satelite',
    selectLanguage: 'Sprache wählen',
    system: 'System',
    theme: 'Thema',
    version: 'Version',
    viewLicenses: 'Lizenzen anschauen',
  };
  static final Map<String, dynamic> es = {
    about: 'Quiénes somos',
    accept: 'Aceptar',
    appDescription: '¡Acelere el desarrollo de aplicaciones sin esfuerzo! Este paquete de Flutter proporciona una potente plantilla inicial con soporte para Material 3, internacionalización sin problemas, fácil manejo de licencias y temas flexibles. Con gestión de estado incorporada y un cajón de navegación para mejorar la experiencia del usuario, inicie su proyecto y vea cómo su aplicación cobra vida con facilidad y destreza.',
    blue: 'Azul',
    brightness: 'Brillo',
    colorScheme: 'Esquema de colores',
    dark: 'Oscuro',
    decline: 'Declinar',
    eulaBody: eula.License.es,
    eulaTitle: 'Contrato de Licencia de Usuario Final',
    exampleText: 'Este es un texto de ejemplo.',
    green: 'Verde',
    language: 'Idioma',
    license: 'Licencia',
    light: 'Claro',
    mainPage: 'Pagina principal',
    menu: 'Menú',
    orange: 'Naranja',
    purple: 'Morado',
    satellite: 'satélite',
    selectLanguage: 'Seleccione el idioma',
    system: 'Sistema',
    theme: 'Tema',
    version: 'Versión',
    viewLicenses: 'Ver licencias',
  };
  static final Map<String, dynamic> hu = {
    about: 'Névjegy',
    accept: 'Elfogadom',
    appDescription: 'Gyorsítsa fel az alkalmazásfejlesztést könnyedén! Ez a Flutter csomag egy erős alap sablont kínál, amely támogatja a Material 3-at, zökkenőmentes nemzetközivé tételt, könnyű licenckezelést és rugalmas témákat. Beépített állapotkezeléssel és egy navigációs fiókkal a felhasználói élmény fokozása érdekében indítsa el projektjét, és nézze, ahogy az alkalmazás könnyedén és ügyesen életre kel.',
    blue: 'Kék',
    brightness: 'Világosság',
    colorScheme: 'Színséma',
    dark: 'sötét',
    decline: 'Elutasítom',
    eulaBody: eula.License.hu,
    eulaTitle: 'Végfelhasználói Licencszerződés',
    exampleText: 'Ez egy példaszöveg.',
    green: 'Zöld',
    language: 'Nyelv',
    license: 'Licenc',
    light: 'világos',
    mainPage: 'Fő oldal',
    menu: 'Menü',
    orange: 'Narancs',
    purple: 'Lila',
    satellite: 'műhold',
    selectLanguage: 'Válassz nyelvet',
    system: 'Rendszer',
    theme: 'Téma',
    version: 'Verzió',
    viewLicenses: 'Licencek megtekintése',
  };
}