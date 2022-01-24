import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthRepo {
  createAccount(String email, String password) {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      debugPrint('.. UserCredential =>$value');
      FirebaseFirestore.instance.collection(kUsersCollection).add({
        'email': email,
        'password': password,
        'registeredTime': formattedTime,
        'userId': value.user!.uid,
      });
    });
  }
}
