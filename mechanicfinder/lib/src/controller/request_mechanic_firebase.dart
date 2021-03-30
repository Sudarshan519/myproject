

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicfinder/src/models/request.dart';
class RequestServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('requests');
  addRequest(Request request) async {
    var ref = firestore.collection("requests").doc();
 
    print('sending request');
    await ref.set(request.toJson());
    print('request sent');
  }

  updateBook(Request request) async {
  //  print(request.requestid);
    await firestore
        .collection("Request")
        .doc(request.userid)
        .update(request.toJson());
  }

  delBook(request) async {
    var ref = firestore.collection("Request").doc(request.id);

    await ref.delete();
  }

  Future<List<Request>> getRequests() async {
    var data = await firestore.collection('Request').get();
    return data.docs.map<Request>((da) => Request.fromJson(da.data())).toList();
  }
}

final RequestServices requestService = RequestServices();