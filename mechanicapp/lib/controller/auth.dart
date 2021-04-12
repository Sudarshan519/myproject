// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mechanicapp/models/user.dart';
// import 'package:mechanicapp/pages/login.dart';
// import 'package:mechanicapp/pages/request_page.dart';
// import 'package:mechanicapp/service/mechanic_service.dart';

// class Auth {
//   FirebaseAuth user = FirebaseAuth.instance;

//   authchanges() {
//     FirebaseAuth.instance.authStateChanges().listen((User user) {
//       if (user == null) {
//         return false;
//       } else {
//         return true;
//       }
//     });
//   }

//   bool isLoggedin() {
//     if (user.currentUser != null) {
//       return true;
//     } else
//       return false;
//   }

//   signInAnon() async {
//     await user.signInAnonymously();
//   }

//   signup(String email, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//           UserModel users;
//       cloudUser.createNewUSer(userCredential.user.uid, users);
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar(e.code, e.message);
//     } catch (e) {
//       return e.code;
//     }
//   }

//   signin(String email, String pass) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: pass);
//       if (userCredential != null) {
//         Get.to(RequestPage());
//       }
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar(e.code, e.message);
//     } on PlatformException catch (e) {
//       Get.snackbar(e.code, e.message);
//     }
//   }

//   verifyuser() async {
//     User user = FirebaseAuth.instance.currentUser;

//     if (!user.emailVerified) {
//       await user.sendEmailVerification();
//     }
//   }

//   signout() async {
//     await user.signOut();
//     Get.off(LoginView());
//   }

//   //google implementation
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     // Create a new credential
//     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }

// final Auth auth = Auth();
