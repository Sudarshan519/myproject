import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanicfinder/src/models/user.dart';
import 'package:mechanicfinder/src/pages/home.dart';
import 'package:mechanicfinder/src/service/getStroage.dart';
import 'package:mechanicfinder/src/service/user_cloud.dart';

class UserController extends GetxController {
  var userPhoto = ''.obs;
  final picker = ImagePicker();
  var img = null.obs;
  void changePhoto(String photo) {
    this.userPhoto.value = photo;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      img = File(pickedFile.path).obs;
    } else {
      print('No image selected.');
    }
  }

  Rx<UserModel> user = UserModel().obs;
  void onInit() {
    super.onInit();
    getUser();
    // _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }

  // UserController(UserController userController);
  // UserModel get user =>
  //     _userModel.value ?? UserModel(name: 'slkef', email: 's@gmail.com');
  // set user(UserModel value) => this._userModel.value = value;

  getUser() async {
    var storageUser = allStorage.readuser();
    if (storageUser == null) {
      try {
        UserModel userinstance = await CloudUser().getUser();
        print(userinstance.toJson());
        user = userinstance.obs;
      } catch (e) {
        print(e.toString());
      }

      print(user.value.toJson());
      allStorage.writeuser(jsonEncode(user.value.toJson()));
    } else {
      UserModel userinstance = UserModel.fromJson(jsonDecode(storageUser));

      user = userinstance.obs;
    }
  }

  updateUser(UserModel users) async {
    CloudUser().updateUser(user.value.id, users);
    UserModel userinstance = await CloudUser().getUser();
    print(userinstance.toJson());
    user = userinstance.obs;
    allStorage.writeuser(jsonEncode(user.value.toJson()));
    Get.to(HomePage());
  }

  void clear() {
    user.value = UserModel();
  }
}

final userController = Get.put(UserController());
