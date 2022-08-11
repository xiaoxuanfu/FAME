import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final _firestore = FirebaseFirestore.instance;

class WelcomeScreen extends StatefulWidget{
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String _login_details;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Image.asset('assets/images/logo.png'),
                ),
               /* Text(
                  "FAME",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.w900,
                  ),
                ),*/
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                 // textAlign: TextAlign.center,
                  onChanged: (value) {
                    _login_details = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: Icon(Icons.mail, color: Colors.black),
                     // border: OutlineInputBorder(),
                  ),

                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                 // textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Color(0xFF0069FE),
                    //borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async{
                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          // login by username functionality

                          await _firestore
                              .collection('users')
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc){
                                  if (_login_details == doc["username"]){
                                    _login_details = doc.id;
                                  }
                                });
                          });
                          final user = await _auth.signInWithEmailAndPassword(
                              email: _login_details, password: _password);
                          if (user != null) {
                            Navigator.pushNamed(context, "/dash");
                          }
                        } catch (e) {
                          print('error');
                        } finally {
                          _login_details = "";
                          _password = "";
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      minWidth: 200,
                      height: 42,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Dont have an account?",
                    style:TextStyle(color: Colors.blue),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Material(
                    color: Color(0xFF0069FE),
                    //borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),

        ),

      ),
    );
  }





}