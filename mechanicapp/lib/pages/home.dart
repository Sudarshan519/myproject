import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanicapp/controller/auth.dart';
import 'package:mechanicapp/controller/request_cloud.dart';
import 'package:mechanicapp/models/request.dart';
import 'package:mechanicapp/pages/homepage/charts.dart';
import 'package:mechanicapp/pages/widgets/constant.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool value = false;
List myservices = [
  'add service',
  'Flat tyre',
  'Puncture',
  'Engine',
  'JumpStart'
];

class _HomePageState extends State<HomePage> {
  List<Request> requests;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int i = 0;
  List<charts.Series<Sales, int>> _seriesLineData;
  var linedata = [
    Sales(0, 00),
    Sales(2, 20),
    Sales(3, 30),
    Sales(4, 40),
    Sales(5, 50),
    Sales(7, 70),
  ];
  var linedata1 = [
    Sales(0, 00),
    Sales(2, 10),
    Sales(3, 30),
    Sales(4, 50),
    Sales(5, 70),
    Sales(7, 90),
  ];
  var linedata2 = [
    Sales(0, 00),
    Sales(2, 20),
    Sales(3, 30),
    Sales(4, 40),
    Sales(5, 90),
    Sales(7, 100),
  ];

  Widget drawerItem({String name, IconData icon, Function() onpress}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey,
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequest();

    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
  }

  getRequest() async {
    requests = await request.getRequest();
    setState(() {
      i = requests.length;
    });
  }

  void _generateData() {
    var linedata = [
      Sales(0, 10),
      Sales(2, 20),
      Sales(3, 30),
      Sales(4, 40),
      Sales(5, 50),
      Sales(7, 68),
    ];
    var linedata1 = [
      Sales(0, 00),
      Sales(2, 10),
      Sales(3, 30),
      Sales(4, 50),
      Sales(5, 70),
      Sales(7, 90),
    ];
    var linedata2 = [
      Sales(0, 50),
      Sales(2, 70),
      Sales(3, 80),
      Sales(4, 80),
      Sales(5, 90),
      Sales(7, 100),
    ];
    _seriesLineData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.green),
          id: 'Air',
          data: linedata,
          domainFn: (Sales sales, _) => sales.yearval,
          measureFn: (Sales sales, _) => sales.salesval),
    );
    _seriesLineData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.cyan),
          id: 'Air',
          data: linedata1,
          domainFn: (Sales sales, _) => sales.yearval,
          measureFn: (Sales sales, _) => sales.salesval),
    );
    _seriesLineData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.red),
          id: 'Air',
          data: linedata2,
          domainFn: (Sales sales, _) => sales.yearval,
          measureFn: (Sales sales, _) => sales.salesval),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            //color: Color(0xff2b2b2b),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage('image/backgrouond.img'),
                      //     fit: BoxFit.cover),
                      ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/umbrella.png'),
                  ),
                  accountName: Text(auth.user.currentUser.displayName),
                  accountEmail: Text(
                    auth.user.currentUser.email,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                drawerItem(
                    name: 'Request History', icon: Icons.menu_open_rounded),
                drawerItem(name: 'Profile', icon: Icons.person),
                drawerItem(name: 'Category ', icon: Icons.car_repair),
                drawerItem(
                    name: 'Manage Requests', icon: Icons.sort_by_alpha_rounded),
                drawerItem(name: 'Earnings History', icon: Icons.money),
                drawerItem(name: 'Requests Statistics', icon: Icons.person_add),
                drawerItem(name: 'Shop Settings', icon: Icons.settings),
                drawerItem(name: 'Support', icon: Icons.help_center),
                Divider(thickness: 2, color: Colors.white),
                ListTile(
                  title: Text(
                    'Communicate',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                drawerItem(name: 'Change', icon: Icons.lock),
                drawerItem(
                    name: 'Log Out',
                    icon: Icons.logout,
                    onpress: () {
                      auth.signout();
                      Navigator.pushNamed(context, 'login');
                    }),
              ],
            ),
          ),
        ),
      ),
      // appBar: new AppBar(
      //   title: new Text(
      //     'MECHANIC APP',
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      // body: Stack(children: [
      //   Container(alignment: Alignment.topRight,
      //   child: CircleAvatar(radius: 30,child: Icon(Icons.notification_important_rounded)),)
      // ],),
      body: ListView(
        children: [
          Container(
            height: 100,
            color: Colors.green[300],
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.sort,
                      size: 40,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
                Spacer(),
                InkWell(
                  onTap: () {
                    Request req = Request(
                        'auth.user.currentUser.uid',
                        'weel',
                        DateTime.now().toString(),
                        '44.44',
                        '44',
                        'sending',
                        'selksefk');
                    //request.createRequest(req);
                    Navigator.pushNamed(context, 'requestpage');
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueGrey,
                    child: Stack(
                      children: [
                        Center(child: Icon(Icons.notification_important)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 10,
                            child: Text(
                              i.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          OurServices(),
          Container(
              height: 400,
              color: Colors.white,
              child: charts.LineChart(_seriesLineData)),
          SizedBox(height: 10),

          // Expanded(
          //     child: Container(
          //   color: Colors.green,
          // )),
          // StreamBuilder<QuerySnapshot>(
          //   stream: request.request.snapshots(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return Text('Something went wrong');
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Text("Loading");
          //     }

          //     return new ListView(
          //       children: snapshot.data.docs.map((DocumentSnapshot document) {
          //         i++;
          //         // print(i);
          //         Request req = Request.fromJson(document.data());

          //         return Padding(
          //           padding: const EdgeInsets.only(top: 5.0),
          //           child: Container(
          //             color: i.isEven ? Colors.grey[200] : Colors.grey[300],
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Row(
          //                 children: [
          //                   Container(
          //                     decoration: BoxDecoration(
          //                         border: Border.all(
          //                             width: 1,
          //                             color: i.isOdd
          //                                 ? Colors.green[300]
          //                                 : Colors.grey[200]),
          //                         borderRadius: BorderRadius.circular(60),
          //                         boxShadow: [
          //                           BoxShadow(color: Colors.grey)
          //                         ]),
          //                     child: CircleAvatar(
          //                       radius: 50,
          //                       backgroundColor: Colors.grey[300],
          //                       child: Icon(
          //                         Icons.person,
          //                         color: Colors.grey,
          //                         size: 70,
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 10,
          //                   ),
          //                   Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         '${req.userid}Sudarshan Shrestha\n ${req.latitude}, ${req.longitude} ',
          //                         style: kTitleTextstyle.copyWith(
          //                             color: Colors.grey,
          //                             fontWeight: FontWeight.w600),
          //                       ),
          //                       Text(
          //                         'Repair request${req.service}',
          //                         style: kTitleTextstyle.copyWith(
          //                             color: Colors.grey[600],
          //                             fontWeight: FontWeight.w400,
          //                             fontSize: 16),
          //                       ),
          //                       SizedBox(
          //                         height: 5,
          //                       ),
          //                       Wrap(
          //                         children: [
          //                           Chip(
          //                               shape: RoundedRectangleBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(10)),
          //                               backgroundColor: Colors.blue[600],
          //                               // onPressed: () {},
          //                               label: Text('Confirm',
          //                                   style: TextStyle(
          //                                       fontSize: 16,
          //                                       color: Colors.white,
          //                                       fontWeight:
          //                                           FontWeight.w600))),
          //                           SizedBox(width: 10),
          //                           // Chip(
          //                           //     shape: RoundedRectangleBorder(
          //                           //         borderRadius:
          //                           //             BorderRadius.circular(10)),
          //                           //     backgroundColor: Colors.red[600],
          //                           //     // onPressed: () {},
          //                           //     label: Text('Refuse',
          //                           //         style: TextStyle(
          //                           //             fontSize: 16,
          //                           //             color: Colors.white,
          //                           //             fontWeight:
          //                           //                 FontWeight.w600))),
          //                           // SizedBox(width: 10),
          //                           InputChip(
          //                               shape: RoundedRectangleBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(10)),
          //                               backgroundColor: Colors.green,
          //                               onPressed: () {
          //                                 _launchCaller();
          //                               },
          //                               label: Text(' Call ',
          //                                   style: TextStyle(
          //                                       fontSize: 16,
          //                                       color: Colors.white,
          //                                       fontWeight:
          //                                           FontWeight.w600))),
          //                           SizedBox(width: 10),
          //                         ],
          //                       ),
          //                       InputChip(
          //                           shape: RoundedRectangleBorder(
          //                               borderRadius:
          //                                   BorderRadius.circular(10)),
          //                           backgroundColor: Colors.grey[400],
          //                           onPressed: () {
          //                             request.delRequest(req);
          //                             //_launchCaller();
          //                           },
          //                           label: Text(' Delete ',
          //                               style: TextStyle(
          //                                   fontSize: 16,
          //                                   color: Colors.white,
          //                                   fontWeight: FontWeight.w600)))
          //                     ],
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),
        ],
      ),
      bottomSheet: Container(
          height: 100,
          width: double.infinity,
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Acceptin requests',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
              CupertinoSwitch(
                  value: value,
                  onChanged: (v) {
                    setState(() {
                      value = !value;
                    });
                  })
            ],
          )),
    );
  }
}

class OurServices extends StatelessWidget {
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
              "My Services",
              style: kTitleTextstyle,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 140,
                child: ListView.builder(
                    itemCount: myservices.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 4),
                    // itemCount: servicesname.length,
                    itemBuilder: (_, i) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (_) {
                              //   return DetailPage(
                              //       context, servicesname[i], imagesrc[i]);
                              // }));
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
                                  child: Icon(Icons.add),
                                  //   child: Image.asset('imagesrc[i]'),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            myservices[i],
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    })),
            // Center(
            //   child: RaisedButton(
            //       color: Colors.green[300],
            //       onPressed: () {},
            //       child: Text(
            //         'View more',
            //         style: kSubTextStyle,
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}

class Sales {
  int yearval;
  int salesval;
  Sales(this.yearval, this.salesval);
}
