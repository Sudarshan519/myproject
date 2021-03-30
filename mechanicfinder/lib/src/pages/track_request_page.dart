import 'package:flutter/material.dart';

class TrackRequestpage extends StatefulWidget {
  @override
  _TrackRequestpageState createState() => _TrackRequestpageState();
}

class _TrackRequestpageState extends State<TrackRequestpage> {
  var steps = ['request sent',
  'request received',
  'pickup fixed',
  'picked up',
  'reached mechanic',
  'repairing',
  'completed',
  'sechedule pickup',
  'home delivey'];
 
  List<Step> step=[
    
  
  //  map(p)=>=>steps{Step(title: Text(p[i]))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Your request is being processed'),
          Container(height: 400), Stepper(steps:[  ...steps.map((p)=>Step(title: Text(p[0]), content: Text(' ')))] )],
      ),
    );
  }
}
