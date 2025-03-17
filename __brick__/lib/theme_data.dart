import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'globals.dart' as globals;
import 'languages.dart';
import 'main.dart';
import 'preferences.dart' as preferences;

/// Unique identifiers of each supported color scheme. If you want to add a new
/// color scheme, first you need to add a new identifier to [ColorSchemeId].
enum ColorSchemeId {
  orange,
  purple,
  blue,
  green,
}

/// Instance of this class is used to notify [MyApp] about the new brightness
/// and color scheme to be used.
class BrightnessSelector{
  final ThemeMode brightness;
  final ColorSchemeSet colorSchemeSet;

  const BrightnessSelector({
    required this.colorSchemeSet,
    this.brightness = ThemeMode.system,
  });
}

/// Instances of [ColorSchemeSet] store the [ColorSchemeSet.light] and
/// [ColorSchemeSet.dark] theme. These themes shall be set by [MyApp] when it
/// gets notified by [MyApp.themeNotifier]. The [ColorSchemeSet.getColorString]
/// function is used to translate the color scheme name to all supported
/// languages. Don't forget to add the translations of the name of your new
/// color scheme in [AppLocale]. Whenever you want to define a new
/// [ColorSchemeSet], you need to add it to the [ColorSchemeDefinition] class as
/// a static final variable. Make sure, that you also provide the mapping in the
/// [ColorSchemeDefinition.completeSet] between the name of your new color
/// scheme you defined in the [ColorSchemeId] enum and the new static
/// [ColorSchemeSet] instance you created for your new theme.
class ColorSchemeSet {
  /// unique name
  final String name;
  final ThemeData light;
  final ThemeData dark;
  final String Function(BuildContext) getColorString;

  const ColorSchemeSet({
    required this.name,
    required this.light,
    required this.dark,
    required this.getColorString,
  });
}

/// Collection of static color scheme definitions and static theme setting and
/// querying functions. New color schemes should be added as static final
/// [ColorSchemeSet] definitions to this class and the
/// [ColorSchemeDefinition.completeSet] map needs to be extended with the
/// mapping of the name of the new color scheme defined in the [ColorSchemeId]
/// enum and the corresponding name of the [ColorSchemeSet] definition of the
/// new color scheme.
class ColorSchemeDefinition {
  static final ColorSchemeSet defaultColorSchemeSet = ColorSchemeDefinition
      .orange;

  /// Mapping between the names of a color schemes defined in the
  /// [ColorSchemeId] enum and each of the static [ColorSchemeSet] theme
  /// definitions.
  static final Map<String, ColorSchemeSet> completeSet = {
    ColorSchemeId.orange.name: ColorSchemeDefinition.orange,
    ColorSchemeId.purple.name: ColorSchemeDefinition.purple,
    ColorSchemeId.blue.name: ColorSchemeDefinition.blue,
    ColorSchemeId.green.name: ColorSchemeDefinition.green,
  };

  /// Color scheme definition of orange for light and dark themes.
  static final ColorSchemeSet orange = ColorSchemeSet(
    name: ColorSchemeId.orange.name,
    light: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange, brightness: Brightness.light),
      useMaterial3: true,
    ),
    dark: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange, brightness: Brightness.dark),
      useMaterial3: true,
    ),
    getColorString: AppLocale.orange.getString,
  );

  /// Color scheme definition of purple for light and dark themes.
  static final ColorSchemeSet purple = ColorSchemeSet(
    name: ColorSchemeId.purple.name,
    light: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00E20074),
          brightness: Brightness.light),
      useMaterial3: true,
    ),
    dark: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00E20074),
          brightness: Brightness.dark),
      useMaterial3: true,
    ),
    getColorString: AppLocale.purple.getString,
  );

  /// Color scheme definition of blue for light and dark themes.
  static final ColorSchemeSet blue = ColorSchemeSet(
    name: ColorSchemeId.blue.name,
    light: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, brightness: Brightness.light),
      useMaterial3: true,
    ),
    dark: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, brightness: Brightness.dark),
      useMaterial3: true,
    ),
    getColorString: AppLocale.blue.getString,
  );

  /// Color scheme definition of green for light and dark themes.
  static final ColorSchemeSet green = ColorSchemeSet(
    name: ColorSchemeId.green.name,
    light: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, brightness: Brightness.light),
      useMaterial3: true,
    ),
    dark: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, brightness: Brightness.dark),
      useMaterial3: true,
    ),
    getColorString: AppLocale.green.getString,
  );

  /// Queries the actual color scheme name from the shared preferences and
  /// returns the corresponding [ColorSchemeSet], or
  /// [ColorSchemeDefinition.defaultColorSchemeSet] if not yet saved. In this
  /// latter case, the name of default color scheme shall be automatically
  /// saved in the shared preferences.
  static Future<ColorSchemeSet> get actualColorSchemeSet async {
    final String colorSchemeSetName;
    final String? tempColorSchemeSetName = preferences.getColorSchemeSetName();
    globals.logger.i("Loaded colorSchemeSetName: ${tempColorSchemeSetName ??
        'Color scheme is not yet saved.'}");

    if (tempColorSchemeSetName == null) {
      colorSchemeSetName = ColorSchemeDefinition.defaultColorSchemeSet.name;
      await preferences.setColorSchemeSetName(colorSchemeSetName);
      globals.logger.i(
          "Automatically saved and set colorSchemeSetName: $colorSchemeSetName");
    } else {
      colorSchemeSetName =
      ColorSchemeDefinition.completeSet.containsKey(tempColorSchemeSetName)
          ? tempColorSchemeSetName
          : ColorSchemeDefinition.defaultColorSchemeSet.name;
    }
    return ColorSchemeDefinition.completeSet[colorSchemeSetName]!;
  }

  /// Modifies the color scheme of the app and saves the new color scheme in
  /// the shared preferences.
  static Future<void> setActualColorSchemeSet(
      ColorSchemeSet colorSchemeSet) async {
    ThemeMode brightness = await ColorSchemeDefinition.actualBrightness;
    MyApp.themeNotifier.value =
        BrightnessSelector(colorSchemeSet: colorSchemeSet, brightness: brightness);
    globals.logger.i("Modified colorScheme of the app to: ${colorSchemeSet.name}");
    await preferences.setColorSchemeSetName(colorSchemeSet.name);
    globals.logger.i(
        "Saved colorSchemeSet into Shared Preferences: ${colorSchemeSet
            .name}");
  }

  /// Queries the actual brightness from the shared preferences and returns
  /// the saved value, or [ThemeMode.system] if not yet saved. In this
  //  latter case, the brightness name shall be automatically
  //  saved in the shared preferences.
  static Future<ThemeMode> get actualBrightness async {
    final ThemeMode brightness;
    final ThemeMode? tempBrightness = preferences.getBrightness();

    if (tempBrightness == null) {
      globals.logger.i("Loaded brightness: Brightness is not yet saved.");
      brightness = ThemeMode.system;
      await ColorSchemeDefinition.setActualBrightness(brightness);
      globals.logger.i(
          "Automatically saved and set brightness: ${brightness.name}");
    } else {
      brightness = tempBrightness;
      globals.logger.i("Loaded brightness: ${brightness.name}");
    }

    return brightness;
  }


  /// Modifies the brightness of the app and saves the new brightness in
  /// the shared preferences.
  static Future<void> setActualBrightness(ThemeMode brightness) async {
    final ColorSchemeSet colorSchemeSet = await ColorSchemeDefinition
        .actualColorSchemeSet;

    MyApp.themeNotifier.value =
        BrightnessSelector(colorSchemeSet: colorSchemeSet, brightness: brightness);
    globals.logger.i("Modified brightness of the app to: ${brightness.name}");
    await preferences.setBrightness(brightness);
    globals.logger.i("Saved brightness into Shared Preferences: ${brightness.name}");
  }
}
