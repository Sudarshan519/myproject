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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/models/mechanic.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

import 'const.dart';
import 'customer_vechicle_details.dart';

class ResuestService extends StatefulWidget {
  final double mylatitude;
  final double mylongitude;
  final MechanicModel mechanic;
  

  const ResuestService(  {Key key, this.mylatitude, this.mylongitude,this.mechanic}) : super(key: key);@override
  _ResuestServiceState createState() => _ResuestServiceState();
}

class _ResuestServiceState extends State<ResuestService> {
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
          'Step 1',
          style: headingStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'CHOOSE THE \nSERVICE YOU\n REQUIRE',
              style: headingStyle.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .5,
              child: GridView.builder(
                  itemCount: 4,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        changeIndex(i);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: selectedService == i
                            ? BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 1))
                            : null,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/serviceman.png',
                              height: 140,
                            ),
                            Text(
                              'Repair',
                              style: subtitleStyle.copyWith(
                                  color: Colors.grey[500], fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2)),
            ),
            SizedBox(height: 20),
            Container(
                height: 60,
                width: 350,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    Get.to(CustomerDetails(myposition:LatLng(widget.mylatitude,widget.mylongitude),mechanic :widget.mechanic));
                  },
                  child: Row(
                    children: [
                      Text('CONTINUE', style: titleStyle),
                      Spacer(),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
