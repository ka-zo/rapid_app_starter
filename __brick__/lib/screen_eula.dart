import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localization/flutter_localization.dart';

import 'eula.dart' as eula;
import 'globals.dart' as globals;
import 'languages.dart';
import 'preferences.dart';

class AcceptEulaScreen extends StatelessWidget {
  const AcceptEulaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(eula.appName),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocale.eulaTitle.getString(context),
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(
                      """\n\n${AppLocale.version.getString(context)}: ${globals.packageInfo.version}\n\n${eula.copyright}\n\n${AppLocale.eulaBody.getString(context)}""",
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle accept button press
                      setEulaAccepted(true);
                      globals.logger
                          .i("User accepted EULA. Saved eulaAccepted: True.");
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('Accept'),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle decline button press
                      // Handle decline button press
                      // Exit the app
                      SystemNavigator.pop();
                    },
                    child: const Text('Decline'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
