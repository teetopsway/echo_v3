import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SeedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CollectionReference userPref  = FirebaseFirestore.instance.collection('userPref');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final userId = user.uid;
    var pizzaPref, latinPref, asianPref, _pizzaButton, _latinButton, _asianButton, _radioValue1;

    Future<void> addUserPref() {
      return userPref
          .add({
        'userId': userId,
        'pizzaPref': pizzaPref,
        'latinPref': latinPref,
        'asianPref': asianPref,
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Text(
                "Rate these restaurants, 1 Worst, 3 Best. ",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30.0),
              ),
            Text(
              'Asian',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
            ),
        new Padding(
          padding: new EdgeInsets.all(8.0),
        ),
        new Divider(height: 5.0, color: Colors.black),
        new Padding(
          padding: new EdgeInsets.all(8.0),
        ),
        new Text(
          'Lion is :',
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
              Material(
                elevation: 5,
                color: Colors.teal,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () {
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Next...",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

  }
}