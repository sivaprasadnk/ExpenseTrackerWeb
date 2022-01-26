import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/auth_exception_handler.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthRepo {
  Future<ResponseModel> createAccount(String email, String password) async {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(credential.user!.uid)
            .set({
          'email': email,
          'password': password,
          'registeredTime': formattedTime,
          'userId': credential.user!.uid,
        });
      }
    } catch (e) {
      debugPrint('Exception @createAccount: $e');
      return ResponseModel(
        status: ResponseStatus.error,
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }
    return ResponseModel(status: ResponseStatus.success, message: 'Success');
  }

  Future<ResponseModel> login(String email, String password) async {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(credential.user!.uid)
            .update({
          'lastLoginTime': formattedTime,
        });
      }
    } catch (e) {
      debugPrint('Exception @createAccount: $e');
      return ResponseModel(
        status: ResponseStatus.error,
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }
    return ResponseModel(status: ResponseStatus.success, message: 'Success');
  }
}
