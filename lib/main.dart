import 'package:Vartalapp/userauth/LoginSignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Vartalapp/screens/welcome_screen.dart';
import 'package:Vartalapp/screens/login_screen.dart';
import 'package:Vartalapp/screens/registration_screen.dart';
import 'package:Vartalapp/screens/chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     body1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
