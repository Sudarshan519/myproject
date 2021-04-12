import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/user_controller.dart';
import 'package:mechanicfinder/src/models/user.dart';
import 'package:mechanicfinder/widgets/text_field.dart';

class CompleteprofileView extends GetView {
  final userController = Get.find<UserController>();
  final bool isUpdate;
  final TextEditingController password = TextEditingController();
  var name = TextEditingController();
  final email = TextEditingController();
  final street = TextEditingController();
  final phone = TextEditingController();
  final zip = TextEditingController();
  final city = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  CompleteprofileView({this.isUpdate = false});
  @override
  Widget build(BuildContext context) {
    name.text = userController.user.value.name;
    email.text = userController.user.value.email;
    street.text = userController.user.value.street;
    phone.text = userController.user.value.phone;
    zip.text = userController.user.value.zip;
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
                  controller: city,
                  hintText: 'City',
                  inputBorder: OutlineInputBorder(),
                
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
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      UserModel user = UserModel(
                          name: name.text,
                          phone: phone.text,
                          email: email.text,
                          street: street.text,
                          zip: zip.text,
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
