/* screens/loginPage.dart */

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:echo_v3/screens/homePage.dart';
import 'package:echo_v3/screens/registration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ModalProgressHUD(
          inAsyncCall: showProgress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: new Image.asset('assets/echo_logo.png'),
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
                    hintText: "Email",
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
                onPressed: (){
                  //forgot password screen
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

                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      print(emailValid);
                      if (emailValid == false) {
                        Fluttertoast.showToast(
                            msg: "Please enter an Email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(context,
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
                          email: email, password: password);
                      print(newUser.toString());

                      if (newUser != null) {
                        Fluttertoast.showToast(
                            msg: "Login Successfull",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        setState(() {
                          showProgress = false;
                        });
                      }

                    } on FirebaseAuthException catch (e) {

                      if (e.code == 'user-not-found') {
                        Fluttertoast.showToast(
                            msg: "User Not Found",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(context,
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
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(context,
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
                          'Create Account',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context,
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
    );
  }
}