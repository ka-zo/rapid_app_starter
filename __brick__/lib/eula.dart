import 'languages.dart';

/// [appName] can be customized, if you can either use the automatically
/// retrieved name, or you can manually enter your own app name. This single
/// variable shall be used all over the app, whenever the app name needs to be
/// used.
/// ```dart
/// import 'globals.dart' as globals;
/// final String appName = globals.packageInfo.appName;
/// or
/// const String appName = 'My Awesome App';
/// ```
const String appName = '{{{app_name}}}';

/// Legalese.
const String copyright = '{{{copyright_notice}}}';

/// [License] can be used in the [AppLocale] class in order to provide
/// translations of the license.
final class License {
  static const String en = """
{{{license}}}
""";
  static const String de = """
{{{license}}}
""";
  static const String es = """
{{{license}}}
""";
  static const String hu = """
{{{license}}}
""";
  static const String cz = """
{{{license}}}
""";
  static const String pl = """
{{{license}}}
""";
}
