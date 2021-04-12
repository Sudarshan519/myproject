// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mechanicapp/controller/auth.dart';
// import 'package:mechanicapp/controller/request_cloud.dart';
// import 'package:mechanicapp/models/request.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import '../models/services.dart';
// import 'login.dart';
// import 'profile.dart';
// import 'request_page.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// bool value = false;

// class _HomePageState extends State<HomePage> {
//   List<Request> requests;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   int i = 0;
//   List<charts.Series<Sales, int>> _seriesLineData;
//   var linedata = [
//     Sales(0, 00),
//     Sales(2, 20),
//     Sales(3, 30),
//     Sales(4, 40),
//     Sales(5, 50),
//     Sales(7, 70),
//   ];
//   var linedata1 = [
//     Sales(0, 00),
//     Sales(2, 10),
//     Sales(3, 30),
//     Sales(4, 50),
//     Sales(5, 70),
//     Sales(7, 90),
//   ];
//   var linedata2 = [
//     Sales(0, 00),
//     Sales(2, 20),
//     Sales(3, 30),
//     Sales(4, 40),
//     Sales(5, 90),
//     Sales(7, 100),
//   ];

//   Widget drawerItem({String name, IconData icon, Function() onpress}) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: Colors.grey,
//       ),
//       title: Text(
//         name,
//         style: TextStyle(
//           color: Colors.blueGrey,
//           fontSize: 20,
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getRequest();

//     _seriesLineData = List<charts.Series<Sales, int>>();
//     _generateData();
//   }

//   getRequest() async {
//     requests = await request.getRequest();
//     setState(() {
//       i = requests.length;
//     });
//   }

//   void _generateData() {
//     var linedata = [
//       Sales(0, 10),
//       Sales(2, 20),
//       Sales(3, 30),
//       Sales(4, 40),
//       Sales(5, 50),
//       Sales(7, 68),
//     ];
//     var linedata1 = [
//       Sales(0, 00),
//       Sales(2, 10),
//       Sales(3, 30),
//       Sales(4, 50),
//       Sales(5, 70),
//       Sales(7, 90),
//     ];
//     var linedata2 = [
//       Sales(0, 50),
//       Sales(2, 70),
//       Sales(3, 80),
//       Sales(4, 80),
//       Sales(5, 90),
//       Sales(7, 100),
//     ];
//     _seriesLineData.add(
//       charts.Series(
//           colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.green),
//           id: 'Air',
//           data: linedata,
//           domainFn: (Sales sales, _) => sales.yearval,
//           measureFn: (Sales sales, _) => sales.salesval),
//     );
//     _seriesLineData.add(
//       charts.Series(
//           colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.cyan),
//           id: 'Air',
//           data: linedata1,
//           domainFn: (Sales sales, _) => sales.yearval,
//           measureFn: (Sales sales, _) => sales.salesval),
//     );
//     _seriesLineData.add(
//       charts.Series(
//           colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.red),
//           id: 'Air',
//           data: linedata2,
//           domainFn: (Sales sales, _) => sales.yearval,
//           measureFn: (Sales sales, _) => sales.salesval),
//     );
//   }

//   Widget _buldDrawer() {
//     return Drawer(
//       child: SafeArea(
//         child: Container(
//           //color: Color(0xff2b2b2b),
//           child: ListView(
//             children: [
//               UserAccountsDrawerHeader(
//                 decoration: BoxDecoration(
//                     // image: DecorationImage(
//                     //     image: AssetImage('image/backgrouond.img'),
//                     //     fit: BoxFit.cover),
//                     ),
//                 currentAccountPicture: CircleAvatar(
//                   backgroundImage: AssetImage('assets/umbrella.png'),
//                 ),
//                 accountName: null,
//                 accountEmail: Text(
//                   's@gmail.com',
//                   style: TextStyle(color: Colors.blueGrey),
//                 ),
//               ),
//               // drawerItem(
//               //     name: 'Request History', icon: Icons.menu_open_rounded),
//               drawerItem(
//                   name: 'Profile',
//                   icon: Icons.person,
//                   onpress: () {
//                     Get.to(Profile());
//                   }),
//               // drawerItem(name: 'Category ', icon: Icons.car_repair),
//               // drawerItem(     name: 'Manage Requests', icon: Icons.sort_by_alpha_rounded),
//               //  drawerItem(name: 'Update location', icon: Icons.location_city),
//               //drawerItem(name: 'Update details', icon: Icons.details),
//               //drawerItem(name: 'Add Service', icon: Icons.settings),
//               //drawerItem(name: 'Feedbacks', icon: Icons.help_center),
//               // Divider(thickness: 2, color: Colors.white),
//               // ListTile(
//               //   title: Text(
//               //     'Communicate',
//               //     style: TextStyle(color: Colors.grey, fontSize: 20),
//               //   ),
//               // ),
//               //  drawerItem(name: 'Change', icon: Icons.lock),
//               drawerItem(
//                   name: 'Log Out',
//                   icon: Icons.logout,
//                   onpress: () {
//                     auth.signout();
//                     Get.to(SignInPage());
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.grey[300],
//       drawer: _buldDrawer(),
//       body: RequestPage(_scaffoldKey),

//       //  ListView(
//       //   children: [
//       //     Container(
//       //       height: 100,
//       //       color: Colors.green[300],
//       //       child: Row(
//       //         children: [
//       //           IconButton(
//       //               icon: Icon(
//       //                 Icons.sort,
//       //                 size: 40,
//       //               ),
//       //               onPressed: () {
//       //                 _scaffoldKey.currentState.openDrawer();
//       //               }),
//       //           Spacer(),
//       //           InkWell(
//       //             onTap: () {
//       //               Request req = Request(
//       //                   'auth.user.currentUser.uid',
//       //                   'weel',
//       //                   DateTime.now().toString(),
//       //                   '44.44',
//       //                   '44',
//       //                   'sending',
//       //                   'selksefk');

//       //               Navigator.pushNamed(context, 'requestpage');
//       //             },
//       //             child: CircleAvatar(
//       //               radius: 30,
//       //               backgroundColor: Colors.blueGrey,
//       //               child: Stack(
//       //                 children: [
//       //                   Center(child: Icon(Icons.notification_important)),
//       //                   Align(
//       //                     alignment: Alignment.bottomRight,
//       //                     child: CircleAvatar(
//       //                       backgroundColor: Colors.grey[300],
//       //                       radius: 10,
//       //                       child: Text(
//       //                         i.toString(),
//       //                         style: TextStyle(
//       //                           fontWeight: FontWeight.w500,
//       //                           fontSize: 10,
//       //                         ),
//       //                       ),
//       //                     ),
//       //                   )
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //         ],
//       //       ),
//       //     ),
//       // OurServices(),
//       // Container(
//       //     height: 400,
//       //     color: Colors.white,
//       //     child: charts.LineChart(_seriesLineData)),
//       // SizedBox(height: 10),

//       // Expanded(
//       //     child: Container(
//       //   color: Colors.green,
//       // )),
//       // StreamBuilder<QuerySnapshot>(
//       //   stream: request.request.snapshots(),
//       //   builder: (BuildContext context,
//       //       AsyncSnapshot<QuerySnapshot> snapshot) {
//       //     if (snapshot.hasError) {
//       //       return Text('Something went wrong');
//       //     }

//       //     if (snapshot.connectionState == ConnectionState.waiting) {
//       //       return Text("Loading");
//       //     }

//       //     return new ListView(
//       //       children: snapshot.data.docs.map((DocumentSnapshot document) {
//       //         i++;
//       //         // print(i);
//       //         Request req = Request.fromJson(document.data());

//       //         return Padding(
//       //           padding: const EdgeInsets.only(top: 5.0),
//       //           child: Container(
//       //             color: i.isEven ? Colors.grey[200] : Colors.grey[300],
//       //             child: Padding(
//       //               padding: const EdgeInsets.all(8.0),
//       //               child: Row(
//       //                 children: [
//       //                   Container(
//       //                     decoration: BoxDecoration(
//       //                         border: Border.all(
//       //                             width: 1,
//       //                             color: i.isOdd
//       //                                 ? Colors.green[300]
//       //                                 : Colors.grey[200]),
//       //                         borderRadius: BorderRadius.circular(60),
//       //                         boxShadow: [
//       //                           BoxShadow(color: Colors.grey)
//       //                         ]),
//       //                     child: CircleAvatar(
//       //                       radius: 50,
//       //                       backgroundColor: Colors.grey[300],
//       //                       child: Icon(
//       //                         Icons.person,
//       //                         color: Colors.grey,
//       //                         size: 70,
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   SizedBox(
//       //                     width: 10,
//       //                   ),
//       //                   Column(
//       //                     crossAxisAlignment: CrossAxisAlignment.start,
//       //                     children: [
//       //                       Text(
//       //                         '${req.userid}Sudarshan Shrestha\n ${req.latitude}, ${req.longitude} ',
//       //                         style: kTitleTextstyle.copyWith(
//       //                             color: Colors.grey,
//       //                             fontWeight: FontWeight.w600),
//       //                       ),
//       //                       Text(
//       //                         'Repair request${req.service}',
//       //                         style: kTitleTextstyle.copyWith(
//       //                             color: Colors.grey[600],
//       //                             fontWeight: FontWeight.w400,
//       //                             fontSize: 16),
//       //                       ),
//       //                       SizedBox(
//       //                         height: 5,
//       //                       ),
//       //                       Wrap(
//       //                         children: [
//       //                           Chip(
//       //                               shape: RoundedRectangleBorder(
//       //                                   borderRadius:
//       //                                       BorderRadius.circular(10)),
//       //                               backgroundColor: Colors.blue[600],
//       //                               // onPressed: () {},
//       //                               label: Text('Confirm',
//       //                                   style: TextStyle(
//       //                                       fontSize: 16,
//       //                                       color: Colors.white,
//       //                                       fontWeight:
//       //                                           FontWeight.w600))),
//       //                           SizedBox(width: 10),
//       //                           // Chip(
//       //                           //     shape: RoundedRectangleBorder(
//       //                           //         borderRadius:
//       //                           //             BorderRadius.circular(10)),
//       //                           //     backgroundColor: Colors.red[600],
//       //                           //     // onPressed: () {},
//       //                           //     label: Text('Refuse',
//       //                           //         style: TextStyle(
//       //                           //             fontSize: 16,
//       //                           //             color: Colors.white,
//       //                           //             fontWeight:
//       //                           //                 FontWeight.w600))),
//       //                           // SizedBox(width: 10),
//       //                           InputChip(
//       //                               shape: RoundedRectangleBorder(
//       //                                   borderRadius:
//       //                                       BorderRadius.circular(10)),
//       //                               backgroundColor: Colors.green,
//       //                               onPressed: () {
//       //                                 _launchCaller();
//       //                               },
//       //                               label: Text(' Call ',
//       //                                   style: TextStyle(
//       //                                       fontSize: 16,
//       //                                       color: Colors.white,
//       //                                       fontWeight:
//       //                                           FontWeight.w600))),
//       //                           SizedBox(width: 10),
//       //                         ],
//       //                       ),
//       //                       InputChip(
//       //                           shape: RoundedRectangleBorder(
//       //                               borderRadius:
//       //                                   BorderRadius.circular(10)),
//       //                           backgroundColor: Colors.grey[400],
//       //                           onPressed: () {
//       //                             request.delRequest(req);
//       //                             //_launchCaller();
//       //                           },
//       //                           label: Text(' Delete ',
//       //                               style: TextStyle(
//       //                                   fontSize: 16,
//       //                                   color: Colors.white,
//       //                                   fontWeight: FontWeight.w600)))
//       //                     ],
//       //                   )
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //         );
//       //       }).toList(),
//       //     );
//       //   },
//       // ),
//       //   ],
//       // ),
//       // bottomSheet: Container(
//       //     height: 100,
//       //     width: double.infinity,
//       //     color: Colors.grey[300],
//       //     child: Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //       crossAxisAlignment: CrossAxisAlignment.center,
//       //       children: [
//       //         Text('Accepting requests',
//       //             style: TextStyle(
//       //               color: Colors.black,
//       //               fontSize: 20,
//       //             )),
//       //         CupertinoSwitch(
//       //             value: value,
//       //             onChanged: (v) {
//       //               setState(() {
//       //                 value = !value;
//       //               });
//       //             })
//       //       ],
//       //     )),
//     );
//   }
// }

// class OurServices extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.transparent,
//           boxShadow: [
//             BoxShadow(
//               offset: Offset(0, 4),
//               blurRadius: 30,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "My Services",
//               style: TextStyle(),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//                 height: 140,
//                 child: ListView.builder(
//                     itemCount: myservices.length,
//                     scrollDirection: Axis.horizontal,
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (_, i) {
//                       return Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           InkWell(
//                             onTap: () {},
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 1, color: Colors.grey[300]),
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       offset: Offset(0, 4),
//                                       blurRadius: 30,
//                                       color: Colors.grey,
//                                     ),
//                                   ],
//                                 ),
//                                 width: 100,
//                                 height: 100,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: CachedNetworkImage(
//                                     imageUrl:
//                                         "http://via.placeholder.com/350x150",
//                                     progressIndicatorBuilder: (context, url,
//                                             downloadProgress) =>
//                                         CircularProgressIndicator(
//                                             value: downloadProgress.progress),
//                                     errorWidget: (context, url, error) =>
//                                         Icon(Icons.error),
//                                   ), //Image.network(myservices[i].image)
//                                   //   child: Image.asset('imagesrc[i]'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             myservices[i].name,
//                             style: TextStyle(
//                                 color: Colors.grey[700],
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                         ],
//                       );
//                     })),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Sales {
//   int yearval;
//   int salesval;
//   Sales(this.yearval, this.salesval);
// }
