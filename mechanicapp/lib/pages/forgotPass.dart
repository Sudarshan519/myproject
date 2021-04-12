import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'signup.dart';

class ForgotpassView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Forgot Password',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
                'Enter your email and we will provide you link to reset your password'),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            TextButton(
                onPressed: () {},
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    )),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.orange[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
            InkWell(
              onTap: (){
                Get.to(SignupView());
              },
              child: Text('Dont have account ? Sign up'))
          ],
        ),
      ),
    );
  }
}
