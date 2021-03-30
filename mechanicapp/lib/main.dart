
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanicapp/controller/auth.dart';
import 'package:mechanicapp/pages/homepage/home.dart';
import 'package:mechanicapp/pages/login.dart';
import 'package:mechanicapp/pages/requestpage/request_page.dart';
import 'package:mechanicapp/pages/signup.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        debugShowCheckedModeBanner: false,
      home: 
      auth.user.currentUser!=null?
      HomePage():SignInPage(),
      routes: {
    'login': (_) => SignInPage(),
          'signup': (_) => SignUpPage(),
          'home': (_) => HomePage(),
          'requestpage': (_) => RequestPage(),
      },
    );
  }
}
