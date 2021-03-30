import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/auth.dart';
import 'package:mechanicfinder/src/widgets/text_field.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  UserCredential userCredential;
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  bool loading = false;
  Future loginAuth() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(e.message)));
      } else if (e.code == 'wrong-password') {
        print(e.message);
      }
    } catch (e) {}
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void validation() {
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('password is Empty'),
      ));
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('password is Empty'),
      ));
      return;
    }
    if (!validateEmail(email.text)) {
      print('email');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Email is not valid '),
      ));
      return;
    } else {
      auth.signin(email.text, password.text);
      Navigator.pushNamed(context, 'home');
    }
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  _showSnackBar(message) {
    final snackBar =
        SnackBar(duration: Duration(seconds: 3), content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    return snackBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3a3e3e),
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'LogIn',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    MyTextField(
                      controller: email,
                      hintText: 'Username',
                      obscureText: false,
                    ),
                    SizedBox(height: 30),
                    MyTextField(
                      controller: password,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                  // color: Colors.red,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) validation();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New user?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'signup');
                      },
                      child: Text(
                        'Register now.',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  Text(
                    'or',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Sign in with',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                          onPressed: () {
                            try {
                              if (_formKey.currentState.validate())
                                auth.signInWithGoogle();
                              
                              if(auth.user!=null)
                              Get.to(HomePage());
                                   
                            } catch (e) {
                              _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text(e.message)));
                            }
                          },
                          child: Text(
                            'Google',
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      await auth.signInWithGoogle();
      if (auth.user != null) {
        _showSnackBar('Welcome  ${auth.user.currentUser.displayName}');

        Get.to(HomePage(
          currentUser: auth.user.currentUser,
        ));
      } else
        print('error signing in');
    } on PlatformException catch (e) {
      if (e.code == 'network_error') _showSnackBar('Connect to internet');
    } on FirebaseException catch (e) {
      _showSnackBar(e.message);
    } catch (e) {
      _showSnackBar(e.toString());
    }
  }
}
