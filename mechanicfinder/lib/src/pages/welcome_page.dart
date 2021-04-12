import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  Widget button({String name, Color color, Color textColor, Function onpress}) {
    return Container(
        height: 45,
        width: 300,
        child: RaisedButton(
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.green, width: 2)),
          onPressed: onpress,
          child: Text(
            name,
            style: TextStyle(color: textColor),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Container(child: Image.asset('assets/serviceman.png')),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Welcome to Mechanic Finder',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Column(
                  children: [
                    Text('Make reservation  in real time'),
                  ],
                ),
                button(
                    name: 'Login',
                    color: Colors.green,
                    textColor: Colors.white,
                    onpress: () {
                      Navigator.pushNamed(context, 'login');
                    }),
                button(
                    name: 'SignUp',
                    color: Colors.white,
                    textColor: Colors.green,
                    onpress: () {
                      Navigator.pushNamed(context, 'signup');
                    }),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
