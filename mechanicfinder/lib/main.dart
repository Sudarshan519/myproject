import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mechanicfinder/src/provider/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/pages/home.dart';
import 'src/pages/login.dart';
import 'src/pages/payment.dart';
import 'src/pages/service_history.dart';
import 'src/pages/set_vechicle.dart';
import 'src/pages/settings.dart';
import 'src/pages/sign_up.dart';
import 'src/pages/track_request_page.dart';
import 'src/pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showlogin = false;
  @override
  void initState() {
    super.initState();
    getlogin();
  }

  getlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool show;
      show = prefs.getBool('welcome');
      if (show == null)
        prefs.setBool('welcome', true);
      else {
        setState(() {
          showlogin = show;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: GetMaterialApp(
        title: 'MechanicFinder',
        theme: ThemeData(
        //  primaryColor: themeColor,
        ),
        home:
            //Payment(),
            auth.user.currentUser != null
                ? HomePage(currentUser: auth.user.currentUser)
                : showlogin
                    ? LoginScreen()
                    : WelcomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          'login': (_) => LoginScreen(),
          'signup': (_) => SignUp(),
          'requesthistory': (_) => ServiceHistoryPage(),
          'profile': (_) => SettingsPage(),
          //'wallet': (_) => MyWallet(),
          'invite_friends': (_) => InviteFriends(),
          'support': (_) => SupportPage(),
          //'requestservice': (_) => RequestServicePage(),
          'trackrequest': (_) => TrackRequestpage(),
          'home': (_) => HomePage(
                currentUser: auth.user.currentUser,
              ),
              'myvechicle': (_) => MyVechicle(),
          'payment': (_) => Payment()
        },
      ),
    );
  }
}

class InviteFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class RequestServicePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
