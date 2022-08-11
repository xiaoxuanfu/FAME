import 'package:fame/Screens/welcome_screen.dart';
import 'package:fame/constants.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:fame/Screens/register.dart';
import 'package:fame/Screens/mainmenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:{
        '/': (context) => WelcomeScreen(),
        '/register': (context) => Register(),
        '/mainmenu': (context) => MainMenu(),
       // '/dash':(context) => Dashboard(),
      },
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),

    );
  }
}
