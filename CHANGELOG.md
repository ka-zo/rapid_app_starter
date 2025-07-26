# 0.3.0

- Authentication with Google Firebase is added, including a sign-in screen and a profile page.
- Google social identity provider and e-mail, password based authentication is by
default part of the sign-in process.
- Google sign-in screen and profile page are also automatically translated.
- NavigationBar is added for the home and for the profile page.
- Missing translation is added to the EULA screen for the accept and decline buttons.
- Fixing purple color theme by removing manual color scheme modifications.
- README.md is updated with authentication related sections.
- Flutter packages that are added to the newly created project are upgraded.

# 0.2.1

- Minor fix in the README.md file.

# 0.2.0

- flutter_native_splash package is added to improve user experience by preventing and
customizing the white splash screen displayed by the native app that loads Flutter.
- Rapid App Starter splash image is added to the assets directory.
- Rapid App Starter launcher icons are added to this mason brick.
- New boolean variable called generate_icons is added to this brick to allow the
developer decide if Rapid App Starter launcher icons are needed in the newly
generated app or not.
- Documentation in the README.md file is modifed accordingly.
- Minor fix to improve performance.
- MaterialApp title fixed.

# 0.1.3

- flutter_localization package is upgraded to 0.2.0 and package_info_plus is upgraded to 5.0.1.

# 0.1.2

- Description in brick.yaml is shortened to less than 120 characters.

# 0.1.1

- Badges for the license and for the platform are added.
- Links of screenshots are replaced with URLs to github.
- Unnecessary comments are removed from screen_main.dart.

# 0.1.0

- Initial release supports android.
- Shows splashscreen at startup.
- Reads and writes shared preferences to load and save state.
- Shows license at startup, then forces accepting the license, otherwise the app exits.
- Supports Material 3.
- Supports a navigation drawer, where language, color scheme, theme can be selected, license and about can be displayed. 
- Business logic for supporting four languages: English, German, Hungarian and Spanish.
- Supports predefined color schemes, which can be easily customized.
- Brightness of the app can be easily changed.
