import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class AuthService{

  /// Google Authentication
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null ;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        /// here we store user data in Fire store
        await _firestore.collection("user").doc(user.uid).set({
          "uid": user.uid,
          "userName": user.displayName,
          "email": user.email,
          "profilePicture": user.photoURL,
          "signInMethod": 'google',
          "mobileNumber": user.phoneNumber,
          "lastSignIn": FieldValue.serverTimestamp()
        });
      }
      return user ;
    } catch (error) {
      print("Sign in failed: $error");
    }
  }


}
