import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/models/request.dart';
import 'package:mechanicfinder/src/pages/home.dart';

class RequestServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('requests');
  addRequest(Request request) async {
    var ref = firestore.collection("requests").doc();

    print('sending request');
    await ref.set(request.toJson()).whenComplete(() {
      Get.snackbar('Sending data', 'Connecting to mechanic',
          snackPosition: SnackPosition.BOTTOM);
      Get.to(HomePage());
    });
    print('request sent');
  }

  updateRequest(QueryDocumentSnapshot request) async {
    //  print(request.requestid);
    await users.doc(request.id).update({'status': 'canceled'});
  }

  delRequest(request) async {
    var ref = users.doc(request.id);

    await ref.delete();
  }

  getRequests() async {
    var data = await users
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    return data;
  }
}

final RequestServices requestService = RequestServices();
