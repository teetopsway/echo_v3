/* screens/loginPage.dart */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart'; //These are just imports, they import all of the needed resources and packages.
import 'package:fluttertoast/fluttertoast.dart';
import 'package:echo_v3/screens/homePage.dart';
import 'package:echo_v3/screens/registration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  bool showProgress = false; //initialize variables
  String email, password;
  @override
  Widget build(BuildContext context) {
    return WillPopScope( //Overrides backbutton
      child: Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.all(10), //This is just the spinning wheel that appears when it is loading, it runs indepedently of any other code.
        child: ModalProgressHUD(
          inAsyncCall: showProgress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: new Image.asset('assets/echo_logo.png'), //here is the logo.
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value; // get value from TextField
                },
                decoration: InputDecoration(
                    hintText: "Email", //Hint for the text box
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value; //get value from textField
                },
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
              FlatButton(
                onPressed: () {
                  //forgot password screen to be implemented here.
                },
                textColor: Colors.blue,
                child: Text('Forgot Password?'),
              ),
              Material(
                elevation: 5,
                color: Colors.teal,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")   //These just check the entries to make sure they are what they are suppsoed to be
                          .hasMatch(email);
                      print(emailValid);
                      if (emailValid == false) {
                        Fluttertoast.showToast(
                            msg: "Please enter an Email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.blueAccent, //Flutter toast that pops up telling you if the email is wrong or if the password is wrong.
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        setState(() {
                          showProgress = false;
                        });
                      }
                      showProgress = true;
                    });
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password); //This calls the firebase authentication and checks to see if the password is good or not.
                      print(newUser.toString());

                      if (newUser != null) {
                        Fluttertoast.showToast(
                            msg: "Login Successfull",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));// pushes to the HomePage
                        setState(() {
                          showProgress = false;
                        });
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Fluttertoast.showToast(
                            msg: "User Not Found",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER, //User not found popup
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        setState(() {
                          showProgress = false;
                        });
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        Fluttertoast.showToast(
                            msg: "Incorrect Password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER, //wrong password popup
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        setState(() {
                          showProgress = false;
                        });
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Login",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Create Account', //button that routes to the registration page
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
            ],
          ),
        ),
      ),
    ),
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to exit?'),
          actions: [
            FlatButton(
                child: Text('Yes'),
                onPressed: () => SystemNavigator.pop(),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
    );
  }
}
