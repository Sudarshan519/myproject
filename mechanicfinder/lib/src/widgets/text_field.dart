import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  MyTextField({
    @required this.hintText,
    @required this.obscureText,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        onChanged: (v) {
          print(v);
        },
        validator: (v) {
          if (v.isEmpty)
            return '$hintText is empty';
          else
            return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            labelText: hintText,
            labelStyle: TextStyle(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey))));
  }
}
