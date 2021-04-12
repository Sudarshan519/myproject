import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mechanicapp/models/user.dart';
import 'package:mechanicapp/pages/complete_profile.dart';

class CloudUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> createNewUSer(String id, UserModel user) async {
    try {
      await _firestore.collection("mechaniclist").doc(id).set({
        "mechanicName": user.name,
        "email": user.email,
        "city": user.city,
        "street": user.street,
        "phone": user.phone,
        "zip": user.zip,
        "latitude": user.latitude,
        "longitude": user.longitude,
        "service": user.service,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // updateUser(String id, UserModel user) async {
  //   try {
  //     print(user.name);
  //     await _firestore.collection("mechaniclist").doc(id).update({
  //       "name": user.name,
  //       "email": user.email,
  //       "city": user.city,
  //       "street": user.street,
  //       "phone": user.phone,
  //       "zip": user.zip,
  //       "latitude": user.latitude,
  //       "longitude": user.longitude,
  //       "service": user.service
  //     });
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  Future<UserModel> getUser() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection("mechaniclist")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();

      //         db.collection('users').doc('id').get()
      // .then((docSnapshot) => {
      //   if (docSnapshot.exists) {
      //     db.collection('users').doc('id')
      //       .onSnapshot((doc) => {
      //         // do stuff with the data
      //       });
      //   }
      // });
      // if (doc != null) {
      //   UserModel user = UserModel.fromDocumentSnapshot(doc);
      if (doc.exists)
        return UserModel.fromDocumentSnapshot(doc);
      else {
        UserModel user = UserModel();
        createNewUSer(FirebaseAuth.instance.currentUser.uid, user);
        Get.to(CompleteprofileView());
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

final cloudUser = CloudUser();
