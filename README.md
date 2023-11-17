# rapid_app_starter

[![License: 3-Clause BSD](https://img.shields.io/badge/License-3--Clause_BSD-blue.svg)](https://opensource.org/license/bsd-3-clause)
[![Platform|Android](https://img.shields.io/badge/Platform-Android-blue)](https://www.android.com/)
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Accelerate app development effortlessly! This Flutter package offers a powerful starting template
featuring Material 3 support, seamless internationalization, easy license handling, and flexible
themes. With built-in state management and a navigation drawer for enhanced user experience,
kickstart your project and watch your app come to life with ease and finesse.

## Why this package?

Streamline your app development process effortlessly. Most apps require users to customize language,
color schemes, brightness, and agree to a license — repetitive development tasks you, as a developer,
shouldn't have to redo. This Flutter package simplifies this by providing a pre-built foundation.
Save time and effort, focus on what makes your app unique, while essential customization and
compliance features are seamlessly integrated and ready to use. Get ahead, efficiently.

## Features

- Splash screen: A splash screen is added to allow the initialization of the app and loading the state from
shared preferences.

  <p align="center">
    <img src="./screenshots/10_start.gif?raw=true" alt="Splash screen followed by license display" width="200"/>
  </p>

- License handling: You can add your own license to the [License] class in 
multiple languages. Currently, English, German, Hungarian and Spanish are supported. This license
shall be displayed after the splash screen, the first time the app starts up. The user has to accept 
this license, otherwise the app exits.
  <p align="center">
    <img src="./screenshots/20_accept_license.gif?raw=true" alt="Accept license after startup" width="200"/>
  </p>
- Shared preferences: The app supports state management using the
[shared_preferences](https://pub.dev/packages/shared_preferences) package
- Navigation drawer: The app has a built in navigation drawer defined in the [MyNavigationDrawer]
widget. The user can access  that can be injected into any new page you create.
  <p align="center">
    <img src="./screenshots/30_view_navigation_drawer.gif?raw=true" alt="View navigation drawer" width="200"/>
  </p>
- languages:
  <p align="center">
    <img src="./screenshots/40_set_language.gif?raw=true" alt="Set languages" width="200"/>
  </p>
- Color schemes: The app supports [Material 3](https://m3.material.io/) design with corresponding
widgets and color schemes. The [ColorSchemeDefinition] class contains predefined color schemes.
The user can change the actual color scheme by navigating to the corresponding menu provided by the
[MyNavigationDrawer] class.
  <p align="center">
    <img src="./screenshots/50_set_color_schemes.gif?raw=true" alt="Set color schemes" width="200"/>
  </p>
- Brightness: The user can set the brightness of the app to light, dark or system by navigating to
the corresponding menu provided by the [MyNavigationDrawer] class.
  <p align="center">
    <img src="./screenshots/60_set_brightness.gif?raw=true" alt="Set brightness" width="200"/>
  </p>
- View license: The user can view the accepted license by selecting the corresponding menu in the
navigation drawer widget of the app defined in the [MyNavigationDrawer] class.
  <p align="center">
    <img src="./screenshots/70_view_license.gif?raw=true" alt="View license" width="200"/>
  </p>
- About:
  <p align="center">
    <img src="./screenshots/80_view_about.gif?raw=true" alt="View about" width="200"/>
  </p>
- Logging: the app uses the [logger](https://pub.dev/packages/logger) package as a dependency to
give the developer means for structured logging.

## How to install

Install [Mason CLI](https://pub.dev/packages/mason_cli) it's must have for using Mason bricks.

```
dart pub global activate mason_cli
```

Create your new Flutter project:
```
flutter create {project_name}
```
move to project folder:
```
cd {project_name}
```
Initialize mason:
```
mason init
```
Add mason brick to your project:
```
mason add rapid_app_starter
```
Start generating Infinum architecture folder structure:
```
mason make rapid_app_starter
```

## Variables

| Variable          | Description                                                                                                   | Default                                   | Type      |
| ----------------- | ------------------------------------------------------------------------------------------------------------- | ----------------------------------------- | --------- |
| `verbose`         | If installation of this brick should be verbose                                                               | false                                     | `boolean` |
| `app_name`        | Full name of the app, that should be displayed on the app. This is not the same as the one in pubspec.yaml.   | Rapid App Starter                         | `string`  |
| `copyright_notice`| Copyright notice to be displayed in the app.                                                                  | Copyright (c) 2023 Your Company Name, Inc.| `string`  |
| `license`         | This license shall be displayed by the app, and shall be saved in the LICENSE file of the project.            | BSD-3-Clause                              | `enum`    |

## Output

The following files are created and/or modified.

```
📂 {project_name}
┣ 📂 android
┃ ┣ 📂 app
┃ ┃ ┗ 📄 build.gradle
┃ ┗ 📄 local.properties
┣ 📂 lib
┃ ┣ 📄 eula.dart
┃ ┣ 📄 globals.dart
┃ ┣ 📄 languages.dart
┃ ┣ 📄 main.dart
┃ ┣ 📄 preferences.dart
┃ ┣ 📄 screen_eula.dart
┃ ┣ 📄 screen_main.dart
┃ ┣ 📄 screen_splash.dart
┃ ┣ 📄 theme_data.dart
┃ ┗ 📄 widget_navigationdrawer.dart 
┣ 📄 pubspec.yaml
┗ 📄 LICENSE
```

## Add your own splashscreen image

Add the path to your image in the flutter/assets section of the `pubspec.yaml` file, then reference the image in the build method of the `_MySplashScreenState` class in the `screen_splash.dart` file. 

## Add your own custom license

You can change the license, that shall be displayed by the app, anytime, by
opening the `eula.dart` file, and then modifying the content of the License class.
Requesting the custom license as mason input during installation is not practical, as
the size of the license is most like too big for that. 

## Add new words to the existing dictionaries

Open the `languages.dart` file. First, you need to add a key to the `AppLocale` class as static const String, then you need to use this new key in the static Maps defined for each language in the same class to add the corresponding translations. From that point on, you can reference your new word using the key you defined as static const String previously (in the following example I use "newkey" as the new key), like `AppLocale.newkey.getString(context)`.
