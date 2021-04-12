// import 'package:flutter/material.dart';
// import 'package:get/get_utils/get_utils.dart';

// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final String label;
//   final bool obscureText;
//   final TextEditingController controller;

//   const CustomTextField(
//       {Key key, this.hintText, this.obscureText, this.controller, this.label})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       validator: (v) {
//         if (v.isEmpty)
//           return '$label is empty';
//         else if (label == 'email' && !GetUtils.isEmail(v))
//           return 'Please provide a valid $label';
//         else if (label == 'password' && v.length < 8)
//           return 'Provide strong $label length greater than 8';
//         else
//           return null;
//       },
//       decoration: InputDecoration(
//           labelText: label,
//           hintText: hintText,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//       obscureText: obscureText,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

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
