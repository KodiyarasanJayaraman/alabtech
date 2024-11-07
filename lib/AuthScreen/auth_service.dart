import 'package:alabtech/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Widgets/text_widget.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> emailAuth(
      {required String email,
      required String password,
      required BuildContext context,
      required bool loading}) async {}

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    googleSignIn.signOut();
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          if (await verifyUserEmail(user)) {
            bool isGoogleSignIn = false;
            for (UserInfo provider in user.providerData) {
              if (provider.providerId == GoogleAuthProvider.PROVIDER_ID) {
                isGoogleSignIn = true;
                break;
              }
            }

            if (isGoogleSignIn) {
              Fluttertoast.showToast(
                  msg:
                      'Welcome! ${FirebaseAuth.instance.currentUser?.displayName}');

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            } else {
              Fluttertoast.showToast(
                  msg: "User has not signed in using Google Sign-In");
            }
          } else {}
        } else {}
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Fluttertoast.showToast(msg: "User signed out successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error signing out: $e");
    }
  }

  Future<bool> verifyUserEmail(User usr) async {
    if (usr.emailVerified == true) {
      return true;
    } else {
      FirebaseAuth.instance.currentUser?.sendEmailVerification();

      return false;
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: TextWidget(text: text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
