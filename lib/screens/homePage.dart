import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:echo_v3/screens/seedPage.dart';
import 'package:echo_v3/screens/mapScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference userData =
        FirebaseFirestore.instance.collection('userData');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    var fName;
    var lName;
    var cellNumber;
    final userId = user.uid;
    final bool initSetup = true;
    var a4;

    Future<void> addUserData() {
      return userData
          .add({
            'fName': fName,
            'lName': lName,
            'cellNumber': cellNumber,
            'initSetup': initSetup,
            'userId': userId,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> checkReg() async {
      await FirebaseFirestore.instance
          .collection("userData")
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) {
        value.docs.forEach((result) {
          print(userId);
          print(result.data());
          var a2 = result.data()["userId"];

          if (userId == a2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapScreen()));
            print('pass');
          } else {
            print(a4);
            print('fail');
          }
        });
      });
    }

    checkReg();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                "Let's Get Started!",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 60.0),
              ),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                fName = value; //get the value entered by user.
              },
              decoration: InputDecoration(
                  hintText: "First Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)))),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                lName = value; //get the value entered by user.
              },
              decoration: InputDecoration(
                  hintText: "Last Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)))),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                cellNumber = value; //get the value entered by user.
              },
              decoration: InputDecoration(
                  hintText: "Cell Phone Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)))),
            ),
            Material(
              elevation: 5,
              color: Colors.teal,
              borderRadius: BorderRadius.circular(32.0),
              child: MaterialButton(
                onPressed: () async {
                  if (fName != null || lName != null || cellNumber != null) {
                    addUserData();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SeedPage()));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please Fill All Fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.blueAccent,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
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
      ),
    );
  }
}
