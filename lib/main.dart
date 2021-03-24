/*main.dart*/

import 'package:flutter/material.dart';
import 'package:echo_v3/screens//loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:echo_v3/screens/mapScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EchoApp());
}

class EchoApp extends StatelessWidget {
  // This widget is the root of your application.
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


