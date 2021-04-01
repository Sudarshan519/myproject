import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData icon;
  final TextEditingController controller;
  final IconData suffixIcon;

  const MyTextField({Key key, this.hintText, this.obscureText, this.icon, this.controller, this.suffixIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:Icon(icon),
        suffixIcon: Icon(suffixIcon)
      ),
    );
  }
}

// hintText: 'Email',
//                           obscureText: false,
//                           icon: Icons.mail,
//                           controller: email