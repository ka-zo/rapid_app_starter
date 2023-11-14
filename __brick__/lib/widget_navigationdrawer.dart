import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'eula.dart' as eula;
import 'globals.dart' as globals;
import 'languages.dart';
import 'preferences.dart' as preferences;
import 'theme_data.dart';

/// Material 3 navigation drawer widget that can be added to any new page.
class MyNavigationDrawer extends StatefulWidget {
  const MyNavigationDrawer({super.key});

  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  int _drawerIndex = 0;


  /// Creates a new dialog, filling it dynamically with the supported languages
  /// in order to allow the user to select one of them. If none of them is
  /// selected, it returns null.
  Future<String?> _showLanguageSelectionDialog(
      {required BuildContext context}) async {
    final String? languageCode = await showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          title: Text(AppLocale.selectLanguage.getString(context),
              style: Theme.of(context).textTheme.titleMedium),
          children: globals.localization.supportedLanguageCodes
              .map(
                (languageCode) => SimpleDialogOption(
              onPressed: () => Navigator.pop(context, languageCode),
              child: Text(globals.localization
                  .getLanguageName(languageCode: languageCode)),
            ),
          )
              .toList(),
        ));

    return languageCode;
  }

  /// Creates a new dialog, filling it dynamically with the supported color
  /// schemes in order to allow the user to select one of them. If none of them
  /// is selected, it returns null.
  Future<ColorSchemeSet?> _showColorSchemeSelectionDialog(
      {required BuildContext context}) async {
    final ColorSchemeSet? colorSchemeSet = await showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          title: Text(AppLocale.colorScheme.getString(context),
              style: Theme.of(context).textTheme.titleMedium),
          children: ColorSchemeDefinition.completeSet.entries.map((item) => SimpleDialogOption(
            onPressed: () => Navigator.pop(context, item.value),
            child: Text(item.value.getColorString(context)),
          )
          ).toList(),
        ));
    return colorSchemeSet;
  }

  /// Creates a new dialog, filling it dynamically with the supported brightness
  /// options (light, dark, system) in order to allow the user to select one of
  /// them. If none of them is selected, it returns null.
  Future<ThemeMode?> _showBrightnessSelectionDialog(
      {required BuildContext context}) async {
    final ThemeMode? brightness = await showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          title: Text(AppLocale.theme.getString(context),
              style: Theme.of(context).textTheme.titleMedium),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, ThemeMode.light),
              child: Text(AppLocale.light.getString(context)),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, ThemeMode.dark),
              child: Text(AppLocale.dark.getString(context)),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, ThemeMode.system),
              child: Text(AppLocale.system.getString(context)),
            ),
          ]
        ));
    return brightness;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NavigationDrawer(
      onDestinationSelected: (int idx) async {
        setState(() {
          _drawerIndex = idx;
        });
        Navigator.pop(context);
        switch (idx) {
          case 0:
            if (mounted) {
              final String? languageCode =
              await _showLanguageSelectionDialog(context: context);
              if (languageCode != null) {
                globals.localization.translate(languageCode);
                await preferences.setLanguageCode(languageCode);
                globals.logger.i(
                    "Saved languageCode into Shared Preferences: $languageCode");
              }
            }
            break;
          case 1:
            if (mounted) {
              final ColorSchemeSet? colorSchemeSet =
              await _showColorSchemeSelectionDialog(context: context);
              if (colorSchemeSet != null) {
                ColorSchemeDefinition.setActualColorSchemeSet(colorSchemeSet);
              }
            }
            break;
          case 2:
            if (mounted) {
              final ThemeMode? brightness =
              await _showBrightnessSelectionDialog(context: context);
              if (brightness != null) {
                await ColorSchemeDefinition.setActualBrightness(brightness);
              }
            }
            break;
          case 3:
            if (mounted) {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocale.eulaTitle.getString(context),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Text(
                              AppLocale.eulaBody.getString(context),
                              style: Theme.of(context).textTheme.bodySmall
                          )
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(AppLocale.viewLicenses.getString(context)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showLicensePage(
                            context: context,
                            applicationName: eula.appName,
                            applicationVersion: globals.packageInfo.version,
                            applicationLegalese: eula.copyright,
                          );
                        },
                      ),
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
            break;
          case 4:
            if (mounted) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                        title: Text(eula.appName,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                """${AppLocale.version.getString(
                                    context)}: ${globals.packageInfo
                                    .version}\n\n${AppLocale.appDescription
                                    .getString(context)}""",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ]),
              );
            }
            break;
        }
      },
      selectedIndex: _drawerIndex,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            AppLocale.menu.getString(context),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        NavigationDrawerDestination(
          label: Text(AppLocale.language.getString(context)),
          icon: const Icon(Icons.language),
          selectedIcon: const Icon(Icons.language_rounded),
        ),
        NavigationDrawerDestination(
          label: Text(AppLocale.colorScheme.getString(context)),
          icon: const Icon(Icons.color_lens_outlined),
          selectedIcon: const Icon(Icons.color_lens),
        ),
        NavigationDrawerDestination(
          label: Text(AppLocale.theme.getString(context)),
          icon: const Icon(Icons.brightness_2_outlined),
          selectedIcon: const Icon(Icons.brightness_2_rounded),
        ),
        NavigationDrawerDestination(
          label: Text(AppLocale.license.getString(context)),
          icon: const Icon(Icons.copyright),
          selectedIcon: const Icon(Icons.copyright_outlined),
        ),
        NavigationDrawerDestination(
          label: Text(AppLocale.about.getString(context)),
          icon: const Icon(Icons.description_outlined),
          selectedIcon: const Icon(Icons.description),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
      ],
    );
  }
}
