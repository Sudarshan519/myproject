// class User {
//   String name;
//   String id;
//   String email;
//   String address;
//   String phone;
//   String rating;
//   User({this.id, this.name, this.email, this.address, this.phone,this.rating});

// }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String street;
  String phone;
  String city;
  String zip;
  double latitude;
  double longitude;
  String service;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.street,
      this.city,
      this.phone,
      this.zip,
      this.latitude,
      this.longitude,
      this.service});

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    name = doc["mechanicName"];
    email = doc["email"] ?? "";
    city = doc["city"];
    phone = doc["phone"];
    latitude = doc['latitude'];
    longitude = doc['longitude'];

    street = doc["street"] ?? '';
    zip = doc['zip'] ?? '';
    city = doc['city'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['zip'] = this.zip;
    data['city'] = this.city;
    return data;
  }

  UserModel.fromJson(Map<String, dynamic> doc) {
    id = doc["id"];
    name = doc["name"];
    email = doc["email"];
    city = doc["city"];
    phone = doc["phone"];
    street = doc["street"];
  }
}
