import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:echo_v3/screens/mapScreen.dart';

class mapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State {
  @override
  Widget build(BuildContext context) {
    CollectionReference userPref =
    FirebaseFirestore.instance.collection('userPref');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final userId = user.uid;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
      ),
    );
  }
}