import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  FirebaseAuth user = FirebaseAuth.instance;

  authchanges() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        // print('User is currently signed out!');
        return false;
      } else {
        return true;
      }
    });
  }

  bool isLoggedin() {
    if (user.currentUser != null) {
      return true;
    } else
      return false;
  }

  signInAnon() async {
    // UserCredential userCredential =
    await user.signInAnonymously();
  }

  signup(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential == null) return null;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        return e.message;
      }
    } catch (e) {
      return e.code;
    }
  }

  signin(String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
      if (userCredential != null) return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  verifyuser() async {
    User user = FirebaseAuth.instance.currentUser;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  signout() async {
    await user.signOut();
  }

  //google implementation
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

final Auth auth = Auth();
