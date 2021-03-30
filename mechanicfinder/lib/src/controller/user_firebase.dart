import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicfinder/src/models/user.dart';

class UserFirebase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  addUser(User user) {
    return users
        .add(user.toJson())
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
    Future<List<User>> getRequest() async {
    var data = await users.get();

    return data.docs.map<User>((da) => User.fromJson(da.data())).toList();
  }

  
  deleteUser() {}
}

final UserFirebase userFirebase=UserFirebase();