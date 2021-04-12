import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mechanicapp/controller/authController.dart';
import 'package:mechanicapp/pages/forgotPass.dart';
import 'package:mechanicapp/pages/signup.dart';

class LoginView extends GetView {
  final authController = Get.put(AuthController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[200],
                    child: FlutterLogo(
                      size: 90,
                    ),
                    //      backgroundImage: AssetImage("assets/logo.png"),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Log In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: email,
                    validator: (v) {
                      if (v.isEmpty) return ' Enter a valid email';
                      if (!v.isEmail)
                        return 'Enter a valid email';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Eg. alkdsjf@123',
                        border: OutlineInputBorder())),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: password,
                    validator: (v) {
                      if (v.isEmpty) return ' Enter a valid password';
                      if (v.length < 8)
                        return "Password must be greater than length of 8";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Eg. alkdsjf@123',
                        border: OutlineInputBorder())),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: authController.remembar.value,
                          onChanged: (v) {
                            authController.remembar.value = v;
                          }),
                    ),
                    Text('Remember me'),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          Get.to(ForgotpassView());
                        },
                        child: Text('Forgot Password'))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate())
                      authController.login(email.text, password.text);
                    // Get.to(LoginsuccessView());
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
                SizedBox(height: 30),
                Center(
                    child: InkWell(
                        onTap: () {
                          Get.off(SignupView());
                        },
                        child: Text('Dont have account ? Sign Up')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
