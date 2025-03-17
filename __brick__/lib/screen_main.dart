import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'eula.dart' as eula;
import 'languages.dart';
import 'widget_home.dart';
import 'widget_navigationdrawer.dart';
{{#use_authentication}}
import 'widget_profile.dart';
{{/use_authentication}}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(eula.appName),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        elevation: 5,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: AppLocale.home.getString(context),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.person),
            icon: const Badge(child: Icon(Icons.person_outlined)),
            label: AppLocale.profile.getString(context),
          ),
        ],
      ),
      body: SafeArea(
          child: <Widget> [
            const HomePage(),
            {{#use_authentication}}
            const UserProfilePage(),
            {{/use_authentication}}
          ][currentPageIndex],
      ),
      endDrawer: const MyNavigationDrawer(),
    );
  }
}
