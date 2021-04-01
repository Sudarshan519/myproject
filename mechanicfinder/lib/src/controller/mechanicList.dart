import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicfinder/src/models/mechanic.dart';

class MechanicFirebase {
  CollectionReference mechanic =
      FirebaseFirestore.instance.collection('mechaniclist');
  addUser(MechanicModel mech) {
    return mechanic
        .add(mech.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // Future<void> updateUser() {
  //   return users
  //       .doc('ABC123')
  //       .update({'info.address.location': GeoPoint(53.483959, -2.244644)})
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }
  // Future<void> deleteRequest(User requests) {
  //   return users
  //       .doc()
  //       .delete()
  //       .then((value) => print("Request Deleted"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }
  // getUser(){

  // }
  Future<List<MechanicModel>> getList() async {
    var data = await mechanic.get();

    return data.docs
        .map<MechanicModel>((da) => MechanicModel.fromJson(da.data()))
        .toList();
  }

  // filterMechaic(String city) async {
  //   var data = await mechanic.where('mechanicName', arrayContains:'ranibari').get();
  //   data.docs.forEach((element) {print(element.data()['name']);});
  //   return data.docs
  //       .map<MechanicModel>((da) => MechanicModel.fromJson(da.data()))
  //       .toList();
  // }

  deleteUser() {}
}

final MechanicFirebase mechanicService = MechanicFirebase();
