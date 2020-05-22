import 'package:flutter/material.dart';
import 'constants.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.title, this.color, @required this.onpressed});
  final String title;
  final Color color;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class EntryField extends StatelessWidget {
  EntryField({this.hint, this.onchanged, this.type, this.obscure});
  final String hint;
  final Function onchanged;
  final TextInputType type;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type != null
          ? TextInputType.emailAddress
          : TextInputType.visiblePassword,
      obscureText: obscure != null ? obscure : false,
      onChanged: onchanged,
      decoration: kTextFieldDecoration(hint),
    );
  }
}
