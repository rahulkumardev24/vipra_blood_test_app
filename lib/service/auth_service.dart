import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vipra_lap/screen/admin/admin_login_screen.dart';
import 'package:vipra_lap/screen/dashboard_screen.dart';
import 'package:vipra_lap/screen/start_screen/login_screen.dart';

import '../screen/admin/admin_dashboard_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AuthService {
  /// Google Authentication
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
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
      return user;
    } catch (error) {
      print("Sign in failed: $error");
    }
  }

  /// Sign up with email and password
  Future<User?> signUpWithEmail(String email, String password, String userName,
      BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection("user").doc(user.uid).set({
          "uid": user.uid,
          "userName": userName,
          "email": user.email ?? "",
          "profilePicture": "",
          "signInMethod": 'email',
          "mobileNumber": "",
          "lastSignIn": FieldValue.serverTimestamp()
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      }
      return user;
    } catch (error) {
      print("Sign-up failed: $error");
      return null;
    }
  }

  /// Login with email and password
  Future<User?> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection("user").doc(user.uid).set(
            {"lastSignIn": FieldValue.serverTimestamp()},
            SetOptions(merge: true));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      }
      return user;
    } catch (error) {
      print("Login failed: $error");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Plz SignIn first")));
      return null;
    }
  }

  Future<User?> adminLogin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (email == "rkrahulroy151617@gmail.com" ||
          email == "parkash123@gmail.com") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
        );
        return userCredential.user;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User is not admin")));
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login failed")));
      return null;
    }
  }

  /// Logout function
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  /// admin logout
  Future<void> adminLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const AdminLoginScreen()));
    print("Admin logged out");
  }

  /// password reset
  Future<void> reSetPassword(String email, BuildContext context) async {
    await _auth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Password reset email sent! Check your inbox"),
      backgroundColor: Colors.greenAccent,
    ));
    Navigator.pop(context);
  }
}
