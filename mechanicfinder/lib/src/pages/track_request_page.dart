import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/request_mechanic_firebase.dart';
import 'package:mechanicfinder/src/models/request.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackRequestpage extends StatefulWidget {
  @override
  _TrackRequestpageState createState() => _TrackRequestpageState();
}

class _TrackRequestpageState extends State<TrackRequestpage> {
  Stream allRequestStream = FirebaseFirestore.instance
      .collection('requests')
      //.  .where('status', isEqualTo: 'sending')
      .where('userid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .snapshots();
  List<Request> requests;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    //   getRequest();
    super.initState();
  }

  // getRequest() async {
  //   List<Request> req;
  //   setState(() {
  //     loading = true;
  //   });
  //   req = await requestService.getRequests();
  //   setState(() {
  //     requests = req;
  //     loading = false;
  //   });
  // }

  // var steps = [
  //   'request sent',
  //   'request received',
  //   'pickup fixed',
  //   'picked up',
  //   'reached mechanic',
  //   'repairing',
  //   'completed',
  //   'sechedule pickup',
  //   'home delivey'
  // ];

  List<Step> step = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Requests'),
          backgroundColor: Colors.red.shade900,
        ),
        body: AllRequests(allRequestStream)
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     // Text('Your request is being processed'),
        //     // Container(height: 400), Stepper(steps:[  ...steps.map((p)=>Step(title: Text(p[0]), content: Text(' ')))] )
        //     // Text(
        //     //   'My Requests',
        //     //   style: TextStyle(
        //     //       fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        //     // ),
        //   ],
        // ),
        );
  }
}

class AllRequests extends StatefulWidget {
  final Stream sRequestStream;
  AllRequests(this.sRequestStream);

  @override
  _AllRequestsState createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
  _launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Request> requests = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getrequest();
  }

  getrequest() async {
    List req = await requestService.getRequests();
    print(req.length);

    setState(() {
      requests = req;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.sRequestStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (snapshot.hasData) {
            var doc = snapshot.data.docs;

            return ListView.builder(
                itemCount: doc.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) {
                  return Container(
                    color: i.isEven ? Colors.grey[300] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.grey)]),
                            child: Icon(
                              Icons.person,
                              color: Colors.white30,
                              size: 70,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    doc[i]['datetime'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // Spacer(),
                                  SizedBox(width: 50),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        // color: Colors.green,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      doc[i]['status'],
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                doc[i]['service'],
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 30,
                                child: doc[i].data()['status'] != 'completed'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InputChip(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor: Colors.blue[600],
                                              onPressed: () {
                                                Get.to(RequestDetailPage(
                                                    data: doc[i].data()));
                                                //  Request req = Request(
                                                //                       'auth.user.currentUser.uid',
                                                //                       'weel',
                                                //                       DateTime.now().toString(),
                                                //                       '44.44',
                                                //                       '44',
                                                //                       'sending',
                                                //                       'selksefk');

                                                // snapshot.data.docs[i].reference
                                                //     .update({
                                                //   'status': 'changed'
                                                // }).whenComplete(() =>
                                                //         print('completed'));
                                              },
                                              label: doc[i]['status'] ==
                                                      'changed'
                                                  ? InkWell(
                                                      onTap: () {
                                                        // requestService
                                                        //     .updateRequest(
                                                        //         snapshot.data
                                                        //             .docs[i]);
                                                        // print(snapshot
                                                        //     .data.docs[i].id);
                                                      },
                                                      child: Text(
                                                          doc[i]['status']))
                                                  : Text('View Detail',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w600))),
                                          SizedBox(width: 4),
                                          InputChip(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor: Colors.red[600],
                                              onPressed: () {
                                                snapshot.data.docs[i].reference
                                                    .delete();
                                              },
                                              label: Text('Cancel ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600))),
                                          SizedBox(width: 4),
                                          InputChip(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor: Colors.green,
                                              onPressed: () {
                                                _launchCaller('1232133');
                                              },
                                              label: Text(' Call ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600))),
                                        ],
                                      )
                                    : Text(''),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        });
  }
}

class RequestDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const RequestDetailPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Request Detail')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mechanic Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  )),
              Text(data['mechanicid'],
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Divider(),
              Text('Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  )),
              Text('2jslkejfeswoe',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Divider(),
              Text('Service',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  )),
              Text(data['service'],
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Divider(),
              Text('Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  )),
              Text(data['status'],
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Divider(),
            ],
          ),
        ));
  }
}
