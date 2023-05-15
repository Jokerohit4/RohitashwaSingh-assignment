

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission_may11/pages/home_page.dart';
import 'package:submission_may11/pages/registration_page.dart';

class FireStore{
  var db = FirebaseFirestore.instance;
  void addUser(String firstName,String lastName,String phoneNo,String languagePref,uid, context) {
    try{
      final user = <String, dynamic>{
        "first name": firstName,
        "last name": lastName,
        "phone_no": phoneNo,
        "locale": languagePref,
        "uid":uid,
      };

      db
          .collection("user")
          .doc()
          .set(user)
          .onError((e, _) => debugPrint("Error writing document: $e"))
      .whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) =>  const HomePage())));
    }
    catch (e) {
      // Handle registration errors
      debugPrint('Adding User: $e');
    }
    }
}