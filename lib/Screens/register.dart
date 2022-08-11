import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import "package:rflutter_alert/rflutter_alert.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _firestore = FirebaseFirestore.instance;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  // Text Controllers
  //final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  // Input Fields
 // late String name;
  late String username;
  late String password;
  late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 24.0),
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45.0,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                 /* Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: _usernameController,
                     // maxLength: 255, //Length limit with counter
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name field cannot be empty';
                          // character minimum requirement error handling (not including whitespaces and symbols)
                        } else if (value.split(RegExp(r"[a-zA-Z]")).length - 1 <
                            2) {
                          return 'Name should contain at least 2 alphabets';
                        } else if (RegExp(r"[^a-zA-Z '.-/]").hasMatch(value)) {
                          return 'Name cannot contain that special character';
                        } else {
                          username = value;
                        }
                        return null;
                      },
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: _usernameController,
                     // maxLength: 30, //Length limit with counter
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username field cannot be empty';
                          // character minimum requirement error handling (not including whitespaces and symbols)
                        } else if (value.split(RegExp(r"[a-zA-Z0-9]")).length -
                            1 <
                            3) {
                          return 'Username should contain at least 3 characters';
                        } else if (RegExp(r"[^a-zA-Z0-9._]").hasMatch(value)) {
                          return 'Alphanumeric, dots and underscores only';
                        } else {
                          username = value;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: _passwordController,
                     // maxLength: 128,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password field cannot be empty';
                        } else if (value.length < 6) {
                          return 'Must be at least 6 characters';
                        } else {
                          password = value;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: _emailController,
                    //  maxLength: 320,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail, color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email field cannot be empty';
                        } else if (RegExp(r"[ ]").hasMatch(value)) {
                          return 'Cannot have spaces';
                        } else {
                          email = value;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 45.0),
                    child: Material(
                      color: Color(0xFF0069FE),
                      //borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              bool taken = false;
                              // await to iterate through list of usernames in database and break when match is found (error popup), else allow user creation
                              await _firestore
                                  .collection('users')
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                querySnapshot.docs.forEach((doc) {
                                  if (username == doc["username"]) {
                                    taken = true;
                                  }
                                });
                              });
                              if (taken) {
                                Alert(
                                    context: context,
                                    title: "Username taken",
                                    desc: "Please try another one")
                                    .show();
                                return;
                              }
                              final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              if (newUser != null) {
                                //create database collection "users" with email as documentName and fields: name, username
                                _firestore
                                    .collection('users')
                                    .doc(email)
                                    .set({
                                  'username': username,
                                  'created': DateTime.now()
                                      .toUtc()
                                      .millisecondsSinceEpoch, //Date of account creation
                                });

                                Alert(
                                  context: context,
                                  title: "Success!",
                                  desc:
                                  "Successfully created account '$username'",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Back to MainMenu",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () =>
                                          Navigator.pushNamed(context, "/mainmenu"),
                                      width: 200,
                                    )
                                  ],
                                ).show();
                              }
                            } catch (e) {
                              Alert(
                                  context: context,
                                  title: "Invalid Email",
                                  desc: "Please use a valid email address")
                                  .show();
                            } finally {
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'SIGNUP',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}