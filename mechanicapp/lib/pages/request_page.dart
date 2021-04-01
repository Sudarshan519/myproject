import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanicapp/controller/request_cloud.dart';
import 'package:mechanicapp/models/request.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  Stream allRequestStream = FirebaseFirestore.instance
      .collection('requests')
      .where('status', isEqualTo: 'sending')
      .snapshots();
  Stream acceptedRequestStream = FirebaseFirestore.instance
      .collection('requests')
      .where('status', isEqualTo: 'changed')
      .snapshots();
  Stream completedRequestStream = FirebaseFirestore.instance
      .collection('requests')
      .where('status', isEqualTo: 'completed')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Requests'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.directions_car),
                  text: 'New',
                ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: 'accepted',
                ),
                Tab(
                  icon: Icon(Icons.directions_bike),
                  text: 'completed',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AllRequests(allRequestStream),
              )),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AllRequests(acceptedRequestStream),
              )),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AllRequests(completedRequestStream),
              )),
            ],
          )),
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
  _launchCaller() async {
    const url = "tel:1234567";
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
    List req = await request.getRequest();
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
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [BoxShadow(color: Colors.grey)]),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: i.isEven
                                  ? Colors.grey[200]
                                  : Colors.grey[300],
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 70,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc[i]['datetime'],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
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
                                child: doc[i].data()['status']!='completed'?  Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InputChip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.blue[600],
                                        onPressed: () {
                                          //  Request req = Request(
                                          //                       'auth.user.currentUser.uid',
                                          //                       'weel',
                                          //                       DateTime.now().toString(),
                                          //                       '44.44',
                                          //                       '44',
                                          //                       'sending',
                                          //                       'selksefk');

                                          snapshot.data.docs[i].reference
                                              .update({
                                            'status': 'changed'
                                          }).whenComplete(
                                                  () => print('completed'));
                                        },
                                        label: doc[i]['status'] == 'changed'
                                            ? InkWell(
                                                onTap: () {
                                                  request.update(snapshot.data.docs[i].id, 'completed');
                                                  print(
                                                      snapshot.data.docs[i].id);
                                                },
                                                child: Text('Iscompleted'))
                                            : Text('Confirm',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                    SizedBox(width: 4),
                                    InputChip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.red[600],
                                        onPressed: () {
                                          snapshot.data.docs[i].reference
                                              .delete();
                                        },
                                        label: Text('Delete',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600))),
                                    SizedBox(width: 4),
                                    InputChip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.green,
                                        onPressed: () {
                                          _launchCaller();
                                        },
                                        label: Text(' Call ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600))),
                                  ],
                                ):Text(''),
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
