import 'package:flutter/material.dart';
import 'package:mechanicfinder/src/controller/auth.dart';
import 'package:mechanicfinder/src/controller/request_mechanic_firebase.dart';
import 'package:mechanicfinder/src/models/request.dart';

class ServiceRequestPage extends StatefulWidget {
  final double mylatitude;
  final double mylongitude;
  final String mechanicName;
  ServiceRequestPage(this.mylatitude, this.mylongitude, this.mechanicName);

  @override
  _ServiceRequestPageState createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  String service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Reqiest Service')),
        body: Form(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Select Vechicle type',
                      border: OutlineInputBorder()),
                ),
                DropdownButton(
                  
                    value: service,
                    items: [
                      DropdownMenuItem(
                        child: Text('Repair'),
                        value: 'repair',
                      ),
                      DropdownMenuItem(child: Text('Refuel'), value: 'refuel'),
                      DropdownMenuItem(
                          child: Text('JumpStart Problem'), value: 'battery'),
                      DropdownMenuItem(
                        child: Text('Engine'),
                        value: 'engine',
                      ),
                      DropdownMenuItem(child: Text('Tyre'), value: 'tyre'),
                      DropdownMenuItem(
                        child: Text('Brake'),
                        value: 'brake',
                      ),
                    ],
                    onChanged: (v) {
                      setState(() {
                        service = v;
                      });
                    }),
                RaisedButton(
                    onPressed: () {
                      if (service == null)
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('select a servce'),
                        ));
                      else {
                        Request req = Request(
                            auth.user.currentUser.uid,
                            service,
                            DateTime.now().toString(),
                            widget.mylatitude.toString(),
                            widget.mylongitude.toString(),
                            'sending',
                            widget.mechanicName);
                        requestService.addRequest(req);
                        //  requestService.addRequest(request);
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Your request has been processed'),
                        ));
                      }
                    },
                    child: Text('Send Request'))
              ],
            ),
          ),
        ));
  }
}
