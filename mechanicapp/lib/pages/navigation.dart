import 'package:flutter/material.dart';
import 'package:mechanicapp/pages/homepage/home.dart';
import 'package:mechanicapp/pages/profile/profile.dart';
import 'package:mechanicapp/pages/requestpage/request_page.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 0;
  final String name = 'foo';
  // final FirebaseOptions firebaseOptions = const FirebaseOptions(
  //   appId: '1:468576539400:android:11e5a0c4e4d279ce8f12bd',
  //   apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
  //   projectId: 'mechanicadmin',
  //   messagingSenderId: '448618578101',
  // );
  @override
  void initState() {
    super.initState();
  }

  // Future<void> initializeDefault() async {
  //   FirebaseApp app = await Firebase.initializeApp();
  //   assert(app != null);
  //   print('Initialized default app $app');
  // }

  // Future<void> initializeSecondary() async {
  //   FirebaseApp app =
  //       await Firebase.initializeApp(name: name, options: firebaseOptions);

  //   assert(app != null);
  //   print('Initialized $app');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 0
          ? HomePage()
          : index == 1
              ? RequestPage()
              : Profile(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Colors.grey[200],
        onTap: (v) {
          setState(() {
            index = v;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}
