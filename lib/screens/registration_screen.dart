import 'package:Vartalapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
// import 'welcome_screen.dart';
import 'package:Vartalapp/blocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
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
                title: "REGISTER",
                color: Colors.blueAccent,
                onpressed: () async {
                  setState(() {
                    spin = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    newUser != null
                        ? Navigator.of(context)
                            .pushReplacementNamed(ChatScreen.id)
                        : print("Register user");
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
