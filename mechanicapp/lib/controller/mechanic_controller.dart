import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanicapp/models/user.dart';
import 'package:mechanicapp/pages/request_page.dart';
import 'package:mechanicapp/service/allstorage.dart';
import 'package:mechanicapp/service/mechanic_service.dart';

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
        // print(userinstance.toJson());
        //print(userinstance);
        if (userinstance == null) return null;
        user = userinstance.obs;
      } catch (e) {
        print(e.toString());
        return false;
      }

      print(user.value.toJson());
      allStorage.writeuser(jsonEncode(user.value.toJson()));
    } else {
      UserModel userinstance = UserModel.fromJson(jsonDecode(storageUser));

      user = userinstance.obs;
    }
  }

  updateUser(UserModel users) async {
    //print(user.value.id);
    CloudUser().createNewUSer(user.value.id, users);
    // cloudUser.updateUser(user.value.id, users);
    UserModel userinstance = await CloudUser().getUser();
    print(userinstance.toJson());
    user = userinstance.obs;
    // allStorage.writeuser(jsonEncode(user.value.toJson()));
    Get.to(RequestPage());
  }

  void clear() {
    user.value = UserModel();
  }
}
