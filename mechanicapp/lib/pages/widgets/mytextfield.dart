import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData icon;
  final TextEditingController controller;
  final IconData suffixIcon;

  const MyTextField(
      {Key key,
      this.hintText,
      this.obscureText,
      this.icon,
      this.controller,
      this.suffixIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          suffixIcon: Icon(suffixIcon)),
    );
  }
}

// hintText: 'Email',
//                           obscureText: false,
//                           icon: Icons.mail,
//                           controller: email

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final InputBorder inputBorder;
  final Color hintcolor;
  final Function ontap;
  final bool obscureText;

  const CustomTextField(
      {Key key,
      this.controller,
      this.hintText,
      this.inputBorder,
      this.hintcolor,
      this.ontap,
      this.obscureText = false,
      TextInputType textInputType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (v) {
          if (v.isEmpty) return '$hintText cannot be Empty';
          //email validation
          if (hintText.toLowerCase() == 'email') {
            if (GetUtils.isEmail(v)) return null;
            return 'Invalid email';
          }

          if (hintText.toLowerCase() == 'city' ||
              hintText.toLowerCase() == 'street') {
            if (v.length < 3)
              return 'Enter a valid $hintText';
            else
              return null;
          }

          //validate phone
          if (hintText.toLowerCase() == 'phone') {
            if (v.isPhoneNumber) {
              return null;
            } else
              return 'invalid phone number';
          }
          //validate zip
          if (hintText.toLowerCase() == 'zip') {
            if (v.isNum) {
              return null;
            } else
              return 'invalid';
          } else
            return null;
        },
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            hintText: hintText,
            labelStyle: TextStyle(color: hintcolor),
            labelText: hintText,
            border: inputBorder));
  }
}
