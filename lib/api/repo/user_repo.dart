import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UserRepo {
  Future<ResponseModel> addExpense(
      String title, String amount, String date) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      final DateTime now = DateTime.now();
      final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
      FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kExpenseDatesCollection)
          .doc(date)
          .collection(kExpenseCollection)
          .add({
        'expense': title,
        'amount': amount,
        'createdDate': formattedTime,
        'updatedTime': formattedTime,
      }).then((doc) {
        FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesCollection)
            .doc(date)
            .collection(kExpenseCollection)
            .doc(doc.id)
            .update({
          'expenseDocId': doc.id,
        });
      });
      int total = 0;
      FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kExpenseDatesCollection)
          .doc(date)
          .collection(kExpenseCollection)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          total = total + int.parse(value.docs[i]['amount'].toString());
          debugPrint('...@@ total =>>$total');
        }
      }).then((value) {
        FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesCollection)
            .doc(date)
            .set({
          'totalExpense': total,
          'day': date,
          // 'dateTime_Date':dateTime,
          'updatedTime': formattedTime,
        });
      });

      // FirebaseFirestore.instance
      //     .collection(kUsersCollection)
      //     .doc(userId)
      //     .collection(kExpenseDatesCollection)
      //     .doc(date)
      //     .set({
      //   'totalExpense': total,
      //   'day': date,
      //   'updatedTime': formattedTime,
      // });
    } catch (e) {
      debugPrint(e.toString());
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }

    return ResponseModel(status: ResponseStatus.success, message: 'Success');
  }

  Future<ResponseModel> deleteExpense(String docId, String date) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      debugPrint('.. @@ here  $userId $docId  $date 1');
      FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kExpenseDatesCollection)
          .doc(date)
          .collection(kExpenseCollection)
          .doc(docId)
          .delete()
          .then((_) {
        debugPrint('.. @@ success');
        int total = 0;
        FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesCollection)
            .doc(date)
            .collection(kExpenseCollection)
            .get()
            .then((value) {
          for (int i = 0; i < value.docs.length; i++) {
            total = total + int.parse(value.docs[i]['amount'].toString());
            debugPrint('...@@ total =>>$total');
          }
        }).then((value) {
          final DateTime now = DateTime.now();
          final String formattedTime =
              DateFormat('dd-MM-yyyy  kk:mm').format(now);
          FirebaseFirestore.instance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kExpenseDatesCollection)
              .doc(date)
              .set({
            'totalExpense': total,
            'day': date,
            'updatedTime': formattedTime,
          });
        });
      });

      debugPrint('.. @@ here  12');
    } catch (err) {
      debugPrint(err.toString());
      return ResponseModel(
        status: ResponseStatus.error,
        message: err.toString(),
      );
    }

    return ResponseModel(status: ResponseStatus.success, message: 'Success');
  }
}
