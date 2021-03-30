import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanicfinder/src/controller/auth.dart';
import 'package:mechanicfinder/src/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  static Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegExp regExp = RegExp(SignUp.pattern);
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  UserCredential userCredential;
  bool loading = false;
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  final _formKey = GlobalKey<FormState>();
  Future sendData() async {
    try {
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user.uid)
          .set({
        'firstName': firstname.text,
        'lastName': lastname.text,
        'email': email.text,
        'userid': userCredential.user.uid,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        globalKey.currentState.showSnackBar(SnackBar(
            content: Text('Password should be greater than 7 characters')));
        print('password is too weak');
      } else if (e.code == 'email-already-in-use') {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text('Email already in use')));
        print('account already exsts for email.');
      }
    } on PlatformException catch (e) {
      if (e.code == 'weak-password') {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text(e.toString())));
        print('password is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('account already exsts for email.');
      }
    } catch (e) {
      globalKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        loading = false;
      });
    }
  }

  void validation() {
    if (!validateEmail(email.text)) {
      globalKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Email is not valid '),
      ));
    }
    if (confirmPassword.text.trim().isEmpty ||
        confirmPassword.text.trim() == null) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text('ConfirmPassword is Empty'),
      ));
      return;
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    controller: firstname,
                    hintText: 'username',
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    controller: email,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    controller: password,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    controller: confirmPassword,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  loading
                      ? Row(children: [CircularProgressIndicator()])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 14),
                            button(
                                color: Colors.red,
                                buttonName: 'SignUp',
                                ontap: () {
                                  if (_formKey.currentState.validate()) {
                                    validation();
                                    sendData();
                                    auth
                                        .signup(email.text, password.text)
                                        .then((v) {
                                      globalKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(v.toString()),
                                      ));
                                    });
                                  }
                                  //validation();
                                })
                          ],
                        ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Text(
                      'Already have account\nSignup.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button({String buttonName, Color color, Function ontap}) {
    return Container(
      width: 100,
      child: RaisedButton(
        color: color,
        onPressed: ontap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
