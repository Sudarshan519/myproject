import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/auth.dart';
import 'package:mechanicfinder/src/pages/service_detail.dart';
import 'package:mechanicfinder/src/widgets/carousel_sliderdemo.dart';
import 'package:mechanicfinder/src/widgets/const.dart';

import 'login.dart';
import 'profile.dart';
import 'settings.dart';

final List<String> servicesname = [
  "Wheel Service",
  "Engine Service",
  "Brake Service",
  "Flat Tyre"
];
final List<String> newServices = [
  "CarOil Service",
  "Mirror Service",
  "Gas Service",
  'Tow Truck',
  "Ambulance",
  "Nearby Gas Station",
  "Car materials",
  "Charge",
  "Flat Tyre/Puncture",
  "Gloceries shop",
  "Nearby Resturant/Hotels",
  "Nearby Bus Station ",
];
final List<String> imagesrc = [
  "assets/wheel.jpg",
  "assets/caroil.jpg",
  "assets/mirrorservice.jpg",
  "assets/service3.jpg",
  "assets/brakeservice.jpg",
  "assets/oilservice.jpg",
];

double distance(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
//ts equatorial region is spherical and poles are flat. The total mass of the earth is 5.972 × 1024kg. Its diameter is 12,742 km and the equatorial radius is 6,371 km.

  var EarthRadius = 637137.0; // WGS84 major axis
  double distance = 2 *
      EarthRadius *
      asin(sqrt(pow(sin(lat2 - lat1) / 2, 2) +
          cos(lat1) * cos(lat2) * pow(sin(lon2 - lon1) / 2, 2)));

  return distance;
}

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Choice> choices = const <Choice>[
    const Choice(title: 'Settings', icon: Icons.settings),
    const Choice(title: 'Log out', icon: Icons.exit_to_app),
  ];

  @override
  void initState() {
    super.initState();
  }

  void onItemMenuPress(Choice choice) {
    if (choice.title == 'Log out') {
      auth.signout();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  Widget drawerItem({String name, IconData icon, Function ontap}) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        icon,
        //color: Colors.white,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<Null> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        //exit(0);
        break;
    }
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [
            // CircleAvatar(
            //     // backgroundColor: Colors.red,
            //     // backgroundImage: NetworkImage(
            //     //   auth.user.currentUser.photoURL,
            //     // ),
            //     ),
          ]),
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            //color: Colors.grey[400], //Color(0xff2b2b2b),
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey
                      // image: DecorationImage(
                      //     image: AssetImage('image/backgrouond.img'),
                      //     fit: BoxFit.cover),
                      ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: //currentUser.photoURL != null
                        // ? NetworkImage(auth.user.currentUser.photoURL)
                        //:
                        AssetImage('assets/serviceman.png'),
                  ),
                  accountName: // auth.user.currentUser.displayName != null
                      //? Text(auth.user.currentUser.displayName)

                      Text(''),
                  accountEmail: auth.user.currentUser != null
                      ? Text(auth.user.currentUser.email ?? '')
                      : InkWell(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: Text('Sign in to continue')),
                ),
                drawerItem(
                    name: 'Request History',
                    icon: Icons.menu_open_rounded,
                    ontap:() {
                      Get.to(Profile());
                    }),
                drawerItem(
                    name: 'TrackRequest',
                    icon: Icons.navigation,
                    ontap: () {
                      Navigator.pushNamed(context, 'trackRequest');
                    }),
                drawerItem(name: 'Profile', icon: Icons.person),
                drawerItem(name: 'Cart', icon: Icons.add_shopping_cart),
                drawerItem(name: 'Wallet', icon: Icons.wallet_travel),
                drawerItem(name: 'Invite Friends', icon: Icons.person_add),
                drawerItem(name: 'Support', icon: Icons.help_center),
                drawerItem(
                    name: 'MyVechicle',
                    icon: Icons.help_center,
                    ontap: () {
                      Navigator.pushNamed(context, 'myvechicle');
                    }),
                Divider(thickness: 2, color: Colors.white),
                ListTile(
                  title: Text(
                    'Communicate',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                // drawerItem('Change', Icons.lock),
                drawerItem(
                    name: 'Log Out',
                    icon: Icons.logout,
                    ontap: () {
                      auth.signout();
                      Navigator.pushNamed(context, 'login');
                    }),
              ],
            ),
          ),
        ),
      ),
      // drawer: Drawer(
      //     child: ListView(children: [
      //   UserAccountsDrawerHeader(
      //     accountName: Text(currentUser.displayName),
      //     accountEmail: Text(currentUser.email),
      //     currentAccountPicture: Image.network(currentUser.photoURL),
      //   ),
      //   ListTile(leading: Icon(Icons.home), title: Text('Home')),
      //   ListTile(leading: Icon(Icons.home), title: Text('Mechanic')),
      //   ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
      //   ListTile(leading: Icon(Icons.home), title: Text('Contact Us')),
      //   ListTile(leading: Icon(Icons.home), title: Text('About Us')),
      //   ListTile(leading: Icon(Icons.home), title: Text('Exit')),
      // ])),
      // appBar: AppBar(
      //   title: Text(
      //     'Mechanic Finder',
      //     style: TextStyle(
      //         color: Colors.blueGrey,
      //         fontStyle: FontStyle.italic,
      //         fontWeight: FontWeight.bold),
      //   ),
      //   //centerTitle: true,
      //   actions: <Widget>[
      //     PopupMenuButton<Choice>(
      //       onSelected: onItemMenuPress,
      //       itemBuilder: (BuildContext context) {
      //         return choices.map((Choice choice) {
      //           return PopupMenuItem<Choice>(
      //               value: choice,
      //               child: Row(
      //                 children: <Widget>[
      //                   Icon(
      //                     choice.icon,
      //                     color: primaryColor,
      //                   ),
      //                   Container(
      //                     width: 10.0,
      //                   ),
      //                   Text(
      //                     choice.title,
      //                     style: TextStyle(color: primaryColor),
      //                   ),
      //                 ],
      //               ));
      //         }).toList();
      //       },
      //     ),
      //   ],
      // ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  CarouselWithIndicatorDemo(),
                  PopularService(),
                  NewService(),
                  SizedBox(height: 20),
                  Container(
                      //margin: EdgeInsets.only(left: 30),
                      //padding: EdgeInsets.only(left: 30),
                      height: 170,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 4),
                          //itemCount: servicesname.length,
                          itemBuilder: (_, i) {
                            return MasterCard();
                          }))
                ],
              ),
            )
            //  List
            // Container(
            //   child: StreamBuilder(
            //     stream:
            //         FirebaseFirestore.instance.collection('users').snapshots(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return Center(
            //           child: CircularProgressIndicator(
            //             valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            //           ),
            //         );
            //       } else {
            //         return ListView.builder(
            //           padding: EdgeInsets.all(10.0),
            //           itemBuilder: (context, index) =>
            //               ListTile(title:Text(snapshot.data.docs[index]['name'],),
            //               subtitle: Text(snapshot.data.docs[index]['name'],),),
            //           itemCount: snapshot.data.docs.length,
            //         );
            //       }
            //     },
            //   ),
            // ),

            // Loading
            // Positioned(
            //   child: isLoading
            //       ? Container(
            //           child: Center(
            //             child: CircularProgressIndicator(
            //                 valueColor:
            //                     AlwaysStoppedAnimation<Color>(themeColor)),
            //           ),
            //           color: Colors.white.withOpacity(0.8),
            //         )
            //       : Container(),
            // )
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Nickname: ${document['name']}',
                        style: TextStyle(color: primaryColor),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        'Nickname: ${document['email']}',
                        style: TextStyle(color: primaryColor),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0),
              ),
            ),
          ],
        ),
        onPressed: () {},
        color: greyColor2,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
  }
}

class NewService extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: kShadowColor,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Services",
              style: kTitleTextstyle,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: servicesname.length,
                    itemBuilder: (_, i) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return DetailPage(servicesname[i], imagesrc[i]);
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 30,
                                      color: kShadowColor,
                                    ),
                                  ],
                                ),
                                width: 100,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(imagesrc[i]),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            newServices[i],
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    })),
            Center(
              child: RaisedButton(
                  color: Colors.green[300],
                  onPressed: () {},
                  child: Text(
                    'View more',
                    style: kSubTextStyle,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

class PopularService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: kShadowColor,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular Services",
              style: kTitleTextstyle,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 4),
                    itemCount: servicesname.length,
                    itemBuilder: (_, i) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return DetailPage(servicesname[i], imagesrc[i]);
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 30,
                                      color: kShadowColor,
                                    ),
                                  ],
                                ),
                                width: 100,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(imagesrc[i]),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            servicesname[i],
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

class MasterCard extends StatelessWidget {
  const MasterCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey.withOpacity(.4),
        image: DecorationImage(
          image: AssetImage("assets/d.jpg"),
          fit: BoxFit.fill,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 30,
            color: kShadowColor,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
              left: 20,
              top: 20,
              child: Text('Master Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ))),
          Positioned(
              left: 20,
              bottom: 40,
              child: Text('2020 / 22',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ))),
          Positioned(
              bottom: 10,
              left: 20,
              child: Text(
                '9  0  8  8  7  * * * * *  *',
                textScaleFactor: 1.4,
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
