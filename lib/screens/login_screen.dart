import 'package:Vartalapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Vartalapp/blocks.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'loginscreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  final _auth = FirebaseAuth.instance;
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              EntryField(
                type: TextInputType.emailAddress,
                hint: 'Enter your email',
                onchanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              EntryField(
                obscure: true,
                hint: 'Enter your password',
                onchanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                title: "LOGIN",
                color: Colors.blueAccent,
                onpressed: () async {
                  setState(() {
                    spin = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.of(context).pushReplacementNamed(ChatScreen.id);
                    }
                    setState(() {
                      spin = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
