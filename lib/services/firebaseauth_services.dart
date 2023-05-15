


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:submission_may11/pages/home_page.dart';

import 'firebase_firestore.dart';

class FirebaseAuthServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FireStore();
  void registerUser(String email,String password,firstName, lastName, phNo, languagePref,context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User registration successful
      User? user = userCredential.user;
      _firestore.addUser(firstName, lastName, phNo, languagePref, user?.uid , context);
      debugPrint('Registered user: ${user?.uid}');
    } catch (e) {
      // Handle registration errors
      debugPrint('Registration error: $e');
    }
  }

  void signInUser(String email,String password,context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User sign-in successful
      User? user = userCredential.user;
      if(user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
      else
        {
          Fluttertoast.showToast(
              msg: 'Password or email not correct',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      debugPrint('Signed in user: ${user?.uid}');
    } catch (e) {
      // Handle sign-in errors
      debugPrint('Sign-in error: $e');
      Fluttertoast.showToast(
          msg: e.toString().substring(30),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}