import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeedPage extends StatefulWidget {
  @override
  _SeedPageState createState() => _SeedPageState();
  }


class _SeedPageState extends State {
  @override
  Widget build(BuildContext context) {
    CollectionReference userPref =
        FirebaseFirestore.instance.collection('userPref');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final userId = user.uid;
    var pizzaPref, latinPref, asianPref;

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
      body: ListView(
        children: <Widget>[
          Text(
            "Rate these restaurants, 1 Worst, 3 Best. ",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
          ),
          Text(
            'Asian',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.0),
          ),
          new RadioListTile(
            value: 1,
            groupValue: asianPref,
            title: Text('1'),
            onChanged: (value) {
              setState(() {
                asianPref = value;
                print(asianPref);
              });
            },
          ),
          RadioListTile(
            value: 2,
            groupValue: asianPref,
            title: Text('2'),
            onChanged: (value) {
              setState(() {
                asianPref = value;
              });
            },
          ),
          new Text(
            'Hispanic:',
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
                print(asianPref);
              },
              minWidth: 200.0,
              height: 45.0,
              child: Text(
                "Next...",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}