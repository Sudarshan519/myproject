import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mechanicapp/models/user.dart';
import 'package:mechanicapp/pages/login.dart';
import 'package:mechanicapp/pages/request_page.dart';
import 'package:mechanicapp/service/allstorage.dart';
import 'package:mechanicapp/service/mechanic_service.dart';

class AuthController extends GetxController {
  //var isloggedin=false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> firebaseUser = FirebaseAuth.instance.currentUser.obs;
  User get user => firebaseUser.value;
  //var loading = false.obs;
  var remembar = false.obs;
  // void setLoading(value) {
  //   loading.value = false;
  // }

  @override
  void onInit() {
    super.onInit();

    firebaseUser.bindStream(_auth.authStateChanges());
  }

  //login
  login(String email, String password) async {
    try {
      // loading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //Get.to(CompleteprofileView());
      Get.to(RequestPage());
      //loading.value = false;
    } catch (e) {}
  }

  //signup
  signup(String email, String password) async {
    try {
      //  loading.value = true;
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((v) {
        UserModel users;
        print(v.user.uid);
        cloudUser.createNewUSer(v.user.uid, users).whenComplete(
            () => showSnackbar("completed successfully", 'loadig completed'));
      });
      //   Get.back();
      //showSnackbar("User created successfulle", 'Logging in');
      // }
      //   loading.value = false;

      //  Get.to(RequestPage());
    } on FirebaseAuthException catch (e) {
      showSnackbar(e.code, e.message);
    } catch (e) {
      print(e);
    }
  }

  updateUser(String name, String email, String photoUrl) {
    //   loading.value = true;
    user.updateEmail(email);
    user.updateProfile(displayName: name, photoURL: photoUrl);
    // loading.value = false;
  }

  void logout() {
    allStorage.clearuser();
    Get.off(LoginView());
    _auth.signOut();
  }
}

showSnackbar(String title, String message) {
  Get.snackbar(title, message);
}
