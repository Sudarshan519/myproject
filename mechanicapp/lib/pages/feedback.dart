import 'package:flutter/material.dart';

class MyFeedBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(child: Column(children: [
         Row(children: [
            CircleAvatar(),
            Text('user name'),
          
         ],),
         Text('Thanks'),
        ],),)
      ],),
    );
  }
}