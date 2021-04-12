import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1

    return ThemeData(
      //2

      primaryColor: Colors.red.shade900,
      scaffoldBackgroundColor: Colors.white,
      accentColor: Colors.red.shade800,
      fontFamily: 'Montserrat', //3
      buttonTheme: ButtonThemeData(
        // 4
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.orangeAccent[700],
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.blueGrey,
        ));
  }
}
