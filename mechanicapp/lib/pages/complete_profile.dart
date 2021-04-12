import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicapp/controller/mechanic_controller.dart';
import 'package:mechanicapp/models/user.dart';

import 'widgets/mytextfield.dart';

class CompleteprofileView extends GetView {
  final userController = Get.put(UserController());
  final bool isUpdate;
  final TextEditingController password = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final street = TextEditingController();
  final phone = TextEditingController();
  final zip = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final service = TextEditingController();
  final city = TextEditingController();
  CompleteprofileView({this.isUpdate = false});
  @override
  Widget build(BuildContext context) {
    name.text = userController.user.value.name;
    email.text = userController.user.value.email;
    street.text = userController.user.value.street;
    phone.text = userController.user.value.phone;
    zip.text = userController.user.value.zip;
    latitude.text = userController.user.value.latitude.toString();
    longitude.text = userController.user.value.longitude.toString();
    service.text = userController.user.value.service;
    city.text = userController.user.value.city;
    return Scaffold(
      appBar: AppBar(
        title: isUpdate ? Text('Update Profile') : Text('Complete Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                // Text(
                //   'Complete Profile',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: name,
                  inputBorder: OutlineInputBorder(),
                  hintText: 'Username',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: email,
                  inputBorder: OutlineInputBorder(),
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: street,
                        inputBorder: OutlineInputBorder(),
                        hintText: 'Street',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: phone,
                        inputBorder: OutlineInputBorder(),
                        hintText: 'Phone',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: zip,
                  inputBorder: OutlineInputBorder(),
                  hintText: 'Zip',
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: latitude,
                        inputBorder: OutlineInputBorder(),
                        hintText: 'latitude',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: longitude,
                        inputBorder: OutlineInputBorder(),
                        hintText: 'Longitude',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: service,
                  inputBorder: OutlineInputBorder(),
                  hintText: 'Service',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: city,
                  inputBorder: OutlineInputBorder(),
                  hintText: 'City',
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      UserModel user = UserModel(
                          name: name.text,
                          phone: phone.text,
                          email: email.text,
                          street: street.text,
                          zip: zip.text,
                          latitude: double.parse(latitude.text),
                          longitude: double.parse(longitude.text),
                          service: service.text,
                          city: city.text);
                      userController.updateUser(user);
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: double.infinity,
                      child: Text('Continue')),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.red.shade800,
                      primary: Theme.of(context).scaffoldBackgroundColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
