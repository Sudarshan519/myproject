// import 'package:flutter/material.dart';
// import 'package:mechanicfinder/src/controller/auth.dart';
// import 'package:mechanicfinder/src/controller/request_mechanic_firebase.dart';
// import 'package:mechanicfinder/src/models/request.dart';

// class ServiceRequestPage extends StatefulWidget {
//   final _formKey = GlobalKey<FormState>();

//   final double mylatitude;

//   ServiceRequestPage(double mylatitude, double mylongitude, String mechanicName, this.mylatitude);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Reqiest Service')),
//         body: Form(
//           key: _formKey,
//           child: Container(
//             margin: EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                       hintText: 'Select Vechicle type',
//                       border: OutlineInputBorder()),
//                 ),
//                 DropdownButton(
//                     value: service,
//                     items: [
//                       DropdownMenuItem(
//                         child: Text('Repair'),
//                         value: 'repair',
//                       ),
//                       DropdownMenuItem(child: Text('Refuel'), value: 'refuel'),
//                       DropdownMenuItem(
//                           child: Text('JumpStart Problem'), value: 'battery'),
//                       DropdownMenuItem(
//                         child: Text('Engine'),
//                         value: 'engine',
//                       ),
//                       DropdownMenuItem(child: Text('Tyre'), value: 'tyre'),
//                       DropdownMenuItem(
//                         child: Text('Brake'),
//                         value: 'brake',
//                       ),
//                     ],
//                     onChanged: (v) {
//                       setState(() {
//                         service = v;
//                       });
//                     }),
//                 RaisedButton(
//                     onPressed: () {
//                       if (service == null)
//                         _scaffoldKey.currentState.showSnackBar(SnackBar(
//                           content: Text('select a servce'),
//                         ));
//                       else {
//                         Request req = Request(
//                             auth.user.currentUser.uid,
//                             service,
//                             DateTime.now().toString(),
//                             widget.mylatitude.toString(),
//                             widget.mylongitude.toString(),
//                             'sending',
//                             widget.mechanicName);
//                         requestService.addRequest(req);
//                         //  requestService.addRequest(request);
//                         _scaffoldKey.currentState.showSnackBar(SnackBar(
//                           content: Text('Your request has been processed'),
//                         ));
//                       }
//                     },
//                     child: Text('Send Request'))
//               ],
//             ),
//           ),
//         ));
//   }

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/request_mechanic_firebase.dart';
import 'package:mechanicfinder/src/models/mechanic.dart';
import 'package:mechanicfinder/src/models/request.dart';
import 'package:mechanicfinder/widgets/text_field.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

import 'const.dart';
import 'customer_vechicle_details.dart';

class ResuestService extends StatefulWidget {
  final double mylatitude;
  final double mylongitude;
  final MechanicModel mechanic;
  final String service;
  const ResuestService(
      {Key key, this.mylatitude, this.mylongitude, this.mechanic, this.service})
      : super(key: key);
  @override
  _ResuestServiceState createState() => _ResuestServiceState();
}

class _ResuestServiceState extends State<ResuestService> {
  final vechicleType = TextEditingController();
  final vechicleno = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedService = 0;
  changeIndex(int index) {
    setState(() {
      selectedService = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Send Request',
          style: headingStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Fill YOUR DETAILS',
                      style: headingStyle.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Text('Vechcle Type'),
                    CustomTextField(
                      controller: vechicleType,
                      hintText: 'Eg. car or bike',
                      inputBorder: OutlineInputBorder(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //  Text('Vechicle no.'),
                    CustomTextField(
                      controller: vechicleno,
                      hintText: 'vechicle no',
                      inputBorder: OutlineInputBorder(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Service'),
                    Text('Flat tyre'),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Request req = Request(
                              FirebaseAuth.instance.currentUser.uid,
                              widget.service,
                              DateTime.now().toString(),
                              widget.mylatitude.toString(),
                              widget.mylongitude.toString(),
                              'sending',
                              widget.mechanic.mechanicName,
                              vechicleType.text,
                              vechicleno.text);
                          requestService.addRequest(req);
                          Get.snackbar(
                              'Uploading data', 'Connecting to database',
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      child: Row(
                        children: [
                          Text('CONTINUE', style: titleStyle),
                          Spacer(),
                          Icon(Icons.arrow_forward, color: Colors.white)
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
