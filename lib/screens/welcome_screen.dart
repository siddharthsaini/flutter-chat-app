import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:Vartalapp/blocks.dart';

// String logo;

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcomescreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 40.0,
                  ),
                ),
                Text(
                  ' Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
              title: "LOGIN",
              color: Colors.lightBlueAccent,
              onpressed: () {
                Navigator.of(context).pushNamed(LoginScreen.id);
              },
            ),
            RoundButton(
              title: "REGISTER",
              color: Colors.blueAccent,
              onpressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}


