import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'const.dart';

class CustomerDetails extends StatefulWidget {
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  double fuelValue = 30;
  onvalueChanged(double i) {
    setState(() {
      fuelValue = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.blue)),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text(
          "CUSTOMER CAR DETAILS",
          style: headingStyle.copyWith(color: Colors.blueGrey),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text('Customer Name'),
                TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'eg.Sudarshan ')),
                Divider(),
                Text('Car Make and Model'),
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'eg.Sudarshan '),
                ),
                Divider(),
                Text('Registration No'),
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Tap to write'),
                ),
                Divider(),
                Text('Mileage'),
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'tap to select value'),
                ),
                Divider(),
                Text('Fuel Level'),
                Slider(
                  value: fuelValue,
                  min: 0,
                  max: 100,
                  onChanged: (v) {
                    onvalueChanged(v);
                  },
                ),
              ],
            ),
          ),
          
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {
                Get.snackbar('Uploading data', 'Connecting to database',
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
