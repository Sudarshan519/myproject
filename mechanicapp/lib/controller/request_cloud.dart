import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicapp/models/request.dart';

class FirebaseStorageData {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream requestStream = FirebaseFirestore.instance
      .collection('requests')
      .where('status', isEqualTo: 'sending')
      .snapshots();
  CollectionReference request =
      FirebaseFirestore.instance.collection('requests');
  Future<void> createRequest(Request requests) {
    return request
        .add(requests.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser() {
    return request
        .doc()
        .update({'info.address.location': GeoPoint(53.483959, -2.244644)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  delRequest(Request request) async {
    var ref = firestore.collection("requests").doc(request.datetime);

    await ref.delete();
    print('deleted');
  }

  Future<List<Request>> getRequest() async {
    var data = await request.get();

    return data.docs.map<Request>((da) => Request.fromJson(da.data())).toList();
  }

  Future<void> update(String id, String status) {
    return request.doc(id).update({'status': status}).catchError(
        (error) => print("Failed to update user: $error"));
  }
}

final request = FirebaseStorageData();
