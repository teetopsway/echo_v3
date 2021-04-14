import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart'; //Imports all the needed packages.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:echo_v3/screens/loginPage.dart';


class RegistrationPage extends StatefulWidget { //This block creates the state, meaning that things on the page are dynamic.
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}
class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance; //Initialize the Firebase authentication object
  bool showProgress = false; //initialize variables.
  String email, password;
  @override
  Widget build(BuildContext context) { //build the widget with a builder constructor.
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ModalProgressHUD(
          inAsyncCall: showProgress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Registration Page",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0), //Title text
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) { //Text box to get the entored by the user and puts it in a variable.
                  email = value; //get the value entered by user.
                },
                decoration: InputDecoration(
                    hintText: "Enter your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
              SizedBox(
                height: 20.0, //These are just spacers.
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value; //get the value entered by user.
                },
                decoration: InputDecoration(
                    hintText: "Enter your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
              SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 5,
                color: Colors.teal,
                borderRadius: BorderRadius.circular(32.0), //This block is the button that you press
                child: MaterialButton(
                  onPressed: () async {
                    setState(() { //This saves the state and sets what happens on the button press.
                      showProgress = true;
                    });
                    try {
                      final newuser =
                      await _auth.createUserWithEmailAndPassword( //This checks to see if the user is null, then if they don't exist, they are added to the Firebase authentication collection.
                          email: email, password: password);
                      if (newuser != null) {
                        Navigator.push( //This pushes the "page"/widget back to the loginPage
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );
                        setState(() {
                          showProgress = false;
                        });
                      }
                    } catch (e) {}
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Register",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), //This is just a button that redirects back to the login page.
                  );
                },
                child: Text(
                  "Already Registred? Login Now",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}