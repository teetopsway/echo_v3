import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:echo_v3/screens/mapScreen.dart';

class SeedPage extends StatefulWidget {
  @override
  _SeedPageState createState() => _SeedPageState();
}

var pizzaPref, latinPref, asianPref; //initialize variables.

class _SeedPageState extends State {
  @override
  Widget build(BuildContext context) {
    CollectionReference userPref =
        FirebaseFirestore.instance.collection('userPref'); //initializes the firebase collection, aka calls our collection on FireStore. in this case it calls the 'userPref" collection.
    final FirebaseAuth auth = FirebaseAuth.instance; //initializes firebase authentication object
    final User user = auth.currentUser; //current user stored in variable
    final userId = user.uid; //current user's id number.

    Future<void> addUserPref() {
      return userPref
          .add({
            'userId': userId,
            'pizzaPref': pizzaPref,
            'latinPref': latinPref, //This function adds the user preferences to the collection, with the entered values, including the userId which will serve as our index.
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
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  value: 1,
                  groupValue: asianPref,
                  title: Text('1'), //These are the radio buttons.
                  onChanged: (value) {
                    setState(() {
                      asianPref = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 2,
                  groupValue: asianPref,
                  title: Text('2'),
                  onChanged: (value) {
                    setState(() {
                      asianPref = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 3,
                  groupValue: asianPref,
                  title: Text('3'),
                  onChanged: (value) {
                    setState(() {
                      asianPref = value;
                    });
                  },
                ),
              ),
            ],
          ),
          new Text(
            'Latin:',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  value: 1,
                  groupValue: latinPref,
                  title: Text('1'),
                  onChanged: (value) {
                    setState(() {
                      latinPref = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 2,
                  groupValue: latinPref,
                  title: Text('2'),
                  onChanged: (value) {
                    setState(() {
                      latinPref = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 3,
                  groupValue: latinPref,
                  title: Text('3'),
                  onChanged: (value) {
                    setState(() {
                      latinPref = value;
                    });
                  },
                ),
              ),
            ],
          ),
          new Text(
            'Pizza:',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  value: 1,
                  groupValue: pizzaPref,
                  title: Text('1'),
                  onChanged: (value) {
                    setState(() {
                      pizzaPref = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 2,
                  groupValue: pizzaPref,
                  title: Text('2'),
                  onChanged: (value) {
                    setState(() {
                      pizzaPref = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 3,
                  groupValue: pizzaPref,
                  title: Text('3'),
                  onChanged: (value) {
                    setState(() {
                      pizzaPref = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Material(
            elevation: 5,
            color: Colors.teal,
            borderRadius: BorderRadius.circular(32.0),
            child: MaterialButton(
              onPressed: () {
                if (pizzaPref != null &&
                    latinPref != null && //This just makes sure that the buttons are filled out
                    asianPref != null) {
                  addUserPref();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapScreen())); //This pushes the screen to the mapScreen.
                } else {
                  Fluttertoast.showToast(
                      msg: "Please Rate All Genres",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER, //Popup
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
    );
  }
}
