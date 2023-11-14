import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart' as globals;
import 'languages.dart';

late final SharedPreferences prefs;

/// Members of [PreferenceNames] shall be used as keys when saving data in
/// shared preferences. Using enum instead of strings provides consistency in
/// the code, and minimizes risk of errors.
enum PreferenceNames {
  languageCode,
  eulaAccepted,
  colorSchemeSetName,
  brightness,
}

/// Saves the language code (e.g. en, hu, de) in shared preferences. Checks
/// validity by checking if [val] is a supported language in [AppLocale].
Future<void> setLanguageCode(String val) async {
  if (!globals.localization.supportedLanguageCodes.contains(val)) throw Exception("Not supported language code: $val");
  await prefs.setString(PreferenceNames.languageCode.name, val);
}

/// Reads from the shared preferences and returns the saved language code
/// - or null if not saved.
String? getLanguageCode() {
  return prefs.getString(PreferenceNames.languageCode.name);
}

/// Saves the accepted state of the EULA.
Future<void> setEulaAccepted(bool val) async {
  await prefs.setBool(PreferenceNames.eulaAccepted.name, val);
}

/// Reads from the shared preferences and returns the accepted state of the EULA
/// - or null if not saved.
bool? getEulaAccepted() {
  return prefs.getBool(PreferenceNames.eulaAccepted.name);
}

/// Saves the selected color scheme name.
Future<void> setColorSchemeSetName(String val) async {
  await prefs.setString(PreferenceNames.colorSchemeSetName.name, val);
}

/// Reads from the shared preferences and returns the selected color scheme name
/// - or null if not saved.
String? getColorSchemeSetName() {
  return prefs.getString(PreferenceNames.colorSchemeSetName.name);
}

/// Saves the selected brightness name (light, dark or system).
Future<void> setBrightness(ThemeMode brightness) async {
  await prefs.setString(PreferenceNames.brightness.name, brightness.name);
}

/// Reads from the shared preferences and returns the selected [ThemeMode]
/// - or null if not saved.
ThemeMode? getBrightness() {
  final String? brightnessName = prefs.getString(PreferenceNames.brightness.name);
  if (brightnessName != null) {
    ThemeMode brightness = ThemeMode.values.firstWhere((item) => item.name == brightnessName);
    return brightness;
  } else {
    return null;
  }
}
