import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:survey_kit/survey_kit.dart';
import '../company.dart';

final _firestore = FirebaseFirestore.instance;

class MainMenu extends StatefulWidget {
  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _InvestController = TextEditingController();

  String dropdownvalue = 'cars';
  var items = [
    'cars',
    'tech',
    'sports',
    'fashion',
  ];
  double _currentSliderValue = 1.0;

  @override
  final _auth = FirebaseAuth.instance;
//  static late User loggedInUser;
  static String username = "";




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     /* appBar: AppBar(
        title: Text(''),
        elevation: 5.0,
        backgroundColor: Colors.teal[200],
      ), */
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: _form(context),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Text(
            "GET TO KNOW YOU",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("Name",
            style:TextStyle(color: Colors.black, fontSize: 18),
          ),
          TextFormField(
            controller: _userController,
            decoration: InputDecoration(
              //labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
            validator: (user) {
              if (user == null || user.isEmpty) {
                return 'Name field cannot be empty';
              }
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("Areas of Interest",
            style:TextStyle(color: Colors.black, fontSize: 18),
          ),
          //TODO allow multiple options to be selected
          DropdownButtonFormField(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("Amount to Invest",
            style:TextStyle(color: Colors.black, fontSize: 18),
          ),
          TextFormField(
            controller: _InvestController,
            decoration: InputDecoration(
              //labelText: 'Amount to invest',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
            validator: (amt) {
              if (amt == null || amt.isEmpty) {
                return 'This field cannot be empty';
              }
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("Risk Appetite",
            style:TextStyle(color: Colors.black, fontSize: 18),
          ),
          CupertinoSlider(
            //key: const Key('slider'),
            value: _currentSliderValue,
            max: 2.0,
            min: 0.0,
            divisions: null,
            activeColor: Colors.purple,
            thumbColor: Colors.pink,
            onChanged: (value){
              setState(() {
                _currentSliderValue = value;
              });
            },

          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  CollectionReference users =
                  FirebaseFirestore.instance.collection('users');
                  String? email = _auth.currentUser?.email;
                  users.doc(email).update({
                    'name': _userController.text,
                    'area of interest': dropdownvalue,
                    'investment amount': _InvestController.text,
                    'risk appetite': _currentSliderValue,
                  });
                  // TODO edit this when for you page is created
                  Navigator.pushNamed(context, "/dash");
                }

               // List<Company> filteredCo = [];
                for (Company co in companies) {
                  if (co.volatility < 1 && co.stockprice < int.parse(_InvestController.text) &&
                      co.getCat() == dropdownvalue) {
                    filteredCo.add(co);

                  }
                }
                print(filteredCo);
              },
              child: Container(
                padding: EdgeInsets.all(0.0),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Submit'),
                    Padding(
                      padding: EdgeInsets.only(left:4),
                      child: Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          )





        ],
      ),
    );
  }
}