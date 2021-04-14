/*main.dart
* This is the root of the application*/

import 'package:flutter/material.dart';
import 'package:echo_v3/screens//loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:echo_v3/screens/mapScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //This block starts the application and initializes the apps connection to Firebase.
  await Firebase.initializeApp();
  runApp(EchoApp());
}

class EchoApp extends StatelessWidget {
  // This block points the application to the first widget it will display, which is loginPage.dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}


