import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UserRepo {
  final fireStoreInstance = FirebaseFirestore.instance;

  Future<ResponseModel> addExpense(
      Expense expense, int dailyTotal, int monthlyTotal) async {
    // try {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseMonthsCollection)
        .doc(expense.expenseMonth)
        .collection(expense.expenseDate)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .add({
      'expenseTitle': expense.title,
      'amount': expense.amount,
      'details': expense.details,
      'createdDate': formattedTime,
      'categoryId': expense.categoryIndex,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
    }).then((doc) {
      fireStoreInstance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kExpenseMonthsCollection)
          .doc(expense.expenseMonth)
          .collection(expense.expenseDate)
          .doc(expense.expenseDate)
          .collection(kExpenseCollection)
          .doc(doc.id)
          .update({
        'expenseDocId': doc.id,
      });
    });
    debugPrint(
        '.. @@@ dailyTotal : $dailyTotal   dailyTotal ${expense.amount}');
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseMonthsCollection)
        .doc(expense.expenseMonth)
        .collection(expense.expenseDate)
        .doc(expense.expenseDate)
        .set({
      'totalExpense': dailyTotal + expense.amount,
      'day': expense.expenseDate,
      'updatedTime': formattedTime,
    });

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseMonthsCollection)
        .doc(expense.expenseMonth)
        .update({
      'totalExpense': monthlyTotal + expense.amount,
      'updatedTime': formattedTime,
    });

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .add({
      'expenseTitle': expense.title,
      'amount': expense.amount,
      'details': expense.details,
      'createdDate': formattedTime,
      'categoryId': expense.categoryIndex,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
    });
    // } catch (e) {
    //   debugPrint(e.toString());
    //   return ResponseModel(
    //     status: ResponseStatus.error,
    //     data: '',
    //     message: e.toString(),
    //   );
    // }

    return ResponseModel(
        status: ResponseStatus.success, message: 'Success', data: '');
  }

  Future<ResponseModel> deleteExpense(String docId, String date) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      debugPrint('.. @@ here  $userId $docId  $date 1');
      fireStoreInstance
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
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesCollection)
            .doc(date)
            .collection(kExpenseCollection)
            .get()
            .then((value) {
          for (int i = 0; i < value.docs.length; i++) {
            total = total + int.parse(value.docs[i]['amount'].toString());
            debugPrint('...@@ total 2=>>$total');
          }
        }).then((value) {
          final DateTime now = DateTime.now();
          final String formattedTime =
              DateFormat('dd-MM-yyyy  kk:mm').format(now);
          fireStoreInstance
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
        data: "",
        message: err.toString(),
      );
    }

    return ResponseModel(
        status: ResponseStatus.success, message: 'Success', data: "");
  }

  Future<String> getTodaysExpense() async {
    final DateTime now = DateTime.now();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var date = DateFormat('dd_MM_yyyy').format(now);
    var month = DateFormat('MMM_yyyy').format(now);

    var value = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseMonthsCollection)
        .doc(month)
        .collection(date)
        .doc(date)
        .get();
    var e = value.data()!['totalExpense'].toString();
    debugPrint('.. @@ getTodaysExpense : $e');
    return e;
    // return "";
  }
}
