
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mechanicapp/controller/auth.dart';
import 'package:mechanicapp/pages/login.dart';
import 'package:mechanicapp/pages/signup.dart';

import 'pages/home.dart';
import 'pages/request_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        debugShowCheckedModeBanner: false,
      home: 
      auth.user.currentUser!=null?
      HomePage():HomePage(),
      routes: {
    'login': (_) => SignInPage(),
          'signup': (_) => SignUpPage(),
          'home': (_) => HomePage(),
          'requestpage': (_) => RequestPage(),
      },
    );
  }
}
