import 'eula.dart' as eula;

/// Dictionary for all supported languages (currently English, German,
/// Hungarian, Spanish, Czech and Polish).
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
  static const String home = 'home';
  static const String language = 'language';
  static const String license = 'license';
  static const String light = 'light';
  static const String mainPage = 'Main page';
  static const String menu = 'menu';
  static const String orange = 'orange';
  static const String profile = 'profile';
  static const String purple = 'purple';
  static const String satellite = 'satellite';
  static const String selectLanguage = 'Select language';
  static const String signinAlert = 'sign-in alert';
  static const String system = 'system';
  static const String theme = 'theme';
  static const String userProfile = 'User Profile';
  static const String version = 'version';
  static const String viewLicenses = 'View licenses';
  static const String welcomeAndSignin = 'Welcome and Sign-in';
  static const String welcomeAndSignup = 'Welcome and Sign-up';

  static final Map<String, dynamic> en = {
    about: 'About',
    accept: 'Accept',
    appDescription:
        'Accelerate app development effortlessly! This Flutter package offers a powerful starting template featuring Material 3 support, seamless internationalization, easy license handling, and flexible themes. With built-in state management and a navigation drawer for enhanced user experience, kickstart your project and watch your app come to life with ease and finesse.',
    blue: 'Blue',
    brightness: 'Brightness',
    colorScheme: 'Color scheme',
    dark: 'Dark',
    decline: 'Decline',
    eulaBody: eula.License.en,
    eulaTitle: 'End-User License Agreement',
    exampleText: 'This is an example text.',
    green: 'Green',
    home: 'Home',
    language: 'Language',
    license: 'License',
    light: 'Light',
    mainPage: 'Main page',
    menu: 'Menu',
    orange: 'Orange',
    profile: 'Profile',
    purple: 'Purple',
    satellite: 'satellite',
    selectLanguage: 'Select language',
    signinAlert: 'By signing in, you agree to our terms and conditions.',
    system: 'System',
    theme: 'Theme',
    userProfile: 'User Profile',
    version: 'Version',
    viewLicenses: 'View licenses',
    welcomeAndSignin: "Welcome to ${eula.appName}, please sign in!",
    welcomeAndSignup: "Welcome to ${eula.appName}, please sign up!",
  };
  static final Map<String, dynamic> de = {
    about: 'Impressum',
    accept: 'Zustimmen',
    appDescription:
        'Beschleunigen Sie die App-Entwicklung mühelos! Dieses Flutter-Paket bietet eine leistungsstarke Ausgangsvorlage mit Material 3-Unterstützung, nahtloser Internationalisierung, einfacher Lizenzverwaltung und flexiblen Designs. Mit integriertem Zustandsmanagement und einer Navigationsleiste für eine verbesserte Benutzererfahrung starten Sie Ihr Projekt und sehen Sie zu, wie Ihre App mit Leichtigkeit und Finesse zum Leben erweckt wird.',
    blue: 'Blau',
    brightness: 'Helligkeit',
    colorScheme: 'Farbzusammensetzung',
    dark: 'Dunkel',
    decline: 'Ablehnen',
    eulaBody: eula.License.de,
    eulaTitle: 'Endbenutzer-Lizenzvereinbarung',
    exampleText: 'Dies ist ein Beispieltext.',
    green: 'Grün',
    home: 'Start',
    language: 'Sprache',
    license: 'Lizenz',
    light: 'Hell',
    mainPage: 'Hauptseite',
    menu: 'Menüs',
    orange: 'Orange',
    profile: 'Profil',
    purple: 'Lila',
    satellite: 'Satelite',
    selectLanguage: 'Sprache wählen',
    signinAlert:
        'Mit Ihrer Anmeldung erklären Sie sich mit unseren Allgemeinen Geschäftsbedingungen einverstanden.',
    system: 'System',
    theme: 'Thema',
    userProfile: 'Benutzerprofil',
    version: 'Version',
    viewLicenses: 'Lizenzen anschauen',
    welcomeAndSignin:
        "Willkommen bei ${eula.appName}, bitte melden Sie sich an!",
    welcomeAndSignup:
        "Willkommen bei ${eula.appName}, bitte registrieren Sie sich!",
  };
  static final Map<String, dynamic> es = {
    about: 'Quiénes somos',
    accept: 'Aceptar',
    appDescription:
        '¡Acelere el desarrollo de aplicaciones sin esfuerzo! Este paquete de Flutter proporciona una potente plantilla inicial con soporte para Material 3, internacionalización sin problemas, fácil manejo de licencias y temas flexibles. Con gestión de estado incorporada y un cajón de navegación para mejorar la experiencia del usuario, inicie su proyecto y vea cómo su aplicación cobra vida con facilidad y destreza.',
    blue: 'Azul',
    brightness: 'Brillo',
    colorScheme: 'Esquema de colores',
    dark: 'Oscuro',
    decline: 'Declinar',
    eulaBody: eula.License.es,
    eulaTitle: 'Contrato de Licencia de Usuario Final',
    exampleText: 'Este es un texto de ejemplo.',
    green: 'Verde',
    home: 'Inicio',
    language: 'Idioma',
    license: 'Licencia',
    light: 'Claro',
    mainPage: 'Pagina principal',
    menu: 'Menú',
    orange: 'Naranja',
    profile: 'Perfil',
    purple: 'Morado',
    satellite: 'satélite',
    selectLanguage: 'Seleccione el idioma',
    signinAlert: 'Al registrarse, acepta nuestras condiciones generales.',
    system: 'Sistema',
    theme: 'Tema',
    userProfile: 'Perfil del usuario',
    version: 'Versión',
    viewLicenses: 'Ver licencias',
    welcomeAndSignin:
        "Bienvenido a ${eula.appName}, ¡por favor, inicie sesión!",
    welcomeAndSignup: "Bienvenido a ${eula.appName}, ¡por favor, regístrate!",
  };
  static final Map<String, dynamic> hu = {
    about: 'Névjegy',
    accept: 'Elfogadom',
    appDescription:
        'Gyorsítsa fel az alkalmazásfejlesztést könnyedén! Ez a Flutter csomag egy erős alap sablont kínál, amely támogatja a Material 3-at, zökkenőmentes nemzetközivé tételt, könnyű licenckezelést és rugalmas témákat. Beépített állapotkezeléssel és egy navigációs fiókkal a felhasználói élmény fokozása érdekében indítsa el projektjét, és nézze, ahogy az alkalmazás könnyedén és ügyesen életre kel.',
    blue: 'Kék',
    brightness: 'Világosság',
    colorScheme: 'Színséma',
    dark: 'sötét',
    decline: 'Elutasítom',
    eulaBody: eula.License.hu,
    eulaTitle: 'Végfelhasználói Licencszerződés',
    exampleText: 'Ez egy példaszöveg.',
    green: 'Zöld',
    home: 'Főoldal',
    language: 'Nyelv',
    license: 'Licenc',
    light: 'világos',
    mainPage: 'Fő oldal',
    menu: 'Menü',
    orange: 'Narancs',
    profile: 'Profil',
    purple: 'Lila',
    satellite: 'műhold',
    selectLanguage: 'Válassz nyelvet',
    signinAlert:
        'A bejelentkezéssel Ön elfogadja általános szerződési feltételeinket.',
    system: 'Rendszer',
    theme: 'Téma',
    userProfile: 'Felhasználói Profil',
    version: 'Verzió',
    viewLicenses: 'Licencek megtekintése',
    welcomeAndSignin:
        "Üdvözöljük a ${eula.appName} appban, kérjük jelentkezzen be!",
    welcomeAndSignup:
        "Üdvözöljük a ${eula.appName} appban, kérjük regisztráljon!",
  };
  static final Map<String, dynamic> cz = {
    about: 'O aplikaci',
    accept: 'Přijmout',
    appDescription:
        'Urychlete vývoj aplikace bez námahy! Tento Flutter balíček nabízí výkonnou startovací šablonu s podporou Material 3, snadnou internacionalizací, jednoduchou správou licencí a flexibilními tématy. Díky vestavěnému řízení stavu a navigačnímu panelu pro lepší uživatelský zážitek můžete svůj projekt rychle nastartovat a sledovat, jak vaše aplikace ožívá s lehkostí a elegancí.',
    blue: 'Modrá',
    brightness: 'Jas',
    colorScheme: 'Barevné schéma',
    dark: 'Tmavý režim',
    decline: 'Odmítnout',
    eulaBody: eula.License.cz, // assuming Czech EULA is available
    eulaTitle: 'Licenční smlouva s koncovým uživatelem',
    exampleText: 'Toto je ukázkový text.',
    green: 'Zelená',
    home: 'Domů',
    language: 'Jazyk',
    license: 'Licence',
    light: 'Světlý režim',
    mainPage: 'Hlavní stránka',
    menu: 'Menu',
    orange: 'Oranžová',
    profile: 'Profil',
    purple: 'Fialová',
    satellite: 'Satelitní',
    selectLanguage: 'Vyberte jazyk',
    signinAlert: 'Přihlášením souhlasíte s našimi podmínkami.',
    system: 'Systém',
    theme: 'Motiv',
    userProfile: 'Uživatelský profil',
    version: 'Verze',
    viewLicenses: 'Zobrazit licence',
    welcomeAndSignin: 'Vítejte v ${eula.appName}, přihlaste se!',
    welcomeAndSignup: 'Vítejte v ${eula.appName}, zaregistrujte se!',
  };
  static final Map<String, dynamic> pl = {
    about: 'O aplikacji',
    accept: 'Akceptuj',
    appDescription:
        'Przyspiesz rozwój aplikacji bez wysiłku! Ten pakiet Flutter oferuje potężny szablon startowy z obsługą Material 3, łatwą internacjonalizacją, prostym zarządzaniem licencjami i elastycznymi motywami. Dzięki wbudowanemu zarządzaniu stanem i nawigacji bocznej zapewniającej lepsze doświadczenie użytkownika, rozpocznij swój projekt i obserwuj, jak Twoja aplikacja ożywa z łatwością i finezją.',
    blue: 'Niebieski',
    brightness: 'Jasność',
    colorScheme: 'Schemat kolorów',
    dark: 'Tryb ciemny',
    decline: 'Odrzuć',
    eulaBody: eula.License.pl, // assuming Polish EULA is available
    eulaTitle: 'Umowa licencyjna użytkownika końcowego',
    exampleText: 'To jest przykładowy tekst.',
    green: 'Zielony',
    home: 'Strona główna',
    language: 'Język',
    license: 'Licencja',
    light: 'Tryb jasny',
    mainPage: 'Strona główna',
    menu: 'Menu',
    orange: 'Pomarańczowy',
    profile: 'Profil',
    purple: 'Fioletowy',
    satellite: 'Satelita',
    selectLanguage: 'Wybierz język',
    signinAlert: 'Logując się, akceptujesz nasze warunki.',
    system: 'System',
    theme: 'Motyw',
    userProfile: 'Profil użytkownika',
    version: 'Wersja',
    viewLicenses: 'Zobacz licencje',
    welcomeAndSignin: 'Witamy w ${eula.appName}, zaloguj się!',
    welcomeAndSignup: 'Witamy w ${eula.appName}, zarejestruj się!',
  };
}
