import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UserRepo {
  final fireStoreInstance = FirebaseFirestore.instance;

  // Future<ResponseModel> addExpense(
  //     Expense expense, int dailyTotal, int monthlyTotal) async {
  //   // try {
  //   String userId = FirebaseAuth.instance.currentUser!.uid;
  //   String expenseDocId = "", recentDocId = "";
  //   final DateTime now = DateTime.now();
  //   final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
  //   fireStoreInstance
  //       .collection(kUsersCollection)
  //       .doc(userId)
  //       .collection(kRecentExpensesCollection)
  //       .add({
  //     'expenseTitle': expense.title,
  //     'amount': expense.amount,
  //     'expenseMonth': expense.expenseMonth,
  //     'expenseDate': expense.expenseDate,
  //     'details': expense.details,
  //     'createdDate': formattedTime,
  //     'categoryId': expense.categoryIndex,
  //     'categoryName': expense.categoryName,
  //     'updatedTime': formattedTime,
  //     'expenseDocId': expenseDocId,
  //   }).then((recentDoc) {
  //     recentDocId = recentDoc.id;
  //     fireStoreInstance
  //         .collection(kUsersCollection)
  //         .doc(userId)
  //         .collection(kRecentExpensesCollection)
  //         .doc(recentDocId)
  //         .update({
  //       'recentDocId': recentDoc.id,
  //     });

  //     fireStoreInstance
  //         .collection(kUsersCollection)
  //         .doc(userId)
  //         .collection(kExpenseMonthsCollection)
  //         .doc(expense.expenseMonth)
  //         .collection(expense.expenseDate)
  //         .doc(expense.expenseDate)
  //         .collection(kExpenseCollection)
  //         .add({
  //       'expenseTitle': expense.title,
  //       'amount': expense.amount,
  //       'details': expense.details,
  //       'createdDate': formattedTime,
  //       'categoryId': expense.categoryIndex,
  //       'categoryName': expense.categoryName,
  //       'updatedTime': formattedTime,
  //     }).then((doc) {
  //       expenseDocId = doc.id;
  //       fireStoreInstance
  //           .collection(kUsersCollection)
  //           .doc(userId)
  //           .collection(kExpenseMonthsCollection)
  //           .doc(expense.expenseMonth)
  //           .collection(expense.expenseDate)
  //           .doc(expense.expenseDate)
  //           .collection(kExpenseCollection)
  //           .doc(doc.id)
  //           .update({
  //         'expenseDocId': doc.id,
  //       }).then((value) {
  //         fireStoreInstance
  //             .collection(kUsersCollection)
  //             .doc(userId)
  //             .collection(kRecentExpensesCollection)
  //             .doc(recentDocId)
  //             .update({
  //           'expenseDocId': doc.id,
  //         });
  //       });
  //     });
  //     debugPrint(
  //         '.. @@@ dailyTotal : $dailyTotal   dailyTotal ${expense.amount}');
  //     fireStoreInstance
  //         .collection(kUsersCollection)
  //         .doc(userId)
  //         .collection(kExpenseMonthsCollection)
  //         .doc(expense.expenseMonth)
  //         .collection(expense.expenseDate)
  //         .doc(expense.expenseDate)
  //         .set({
  //       'totalExpense': dailyTotal + expense.amount,
  //       'day': expense.expenseDate,
  //       'updatedTime': formattedTime,
  //     });

  //     fireStoreInstance
  //         .collection(kUsersCollection)
  //         .doc(userId)
  //         .collection(kExpenseMonthsCollection)
  //         .doc(expense.expenseMonth)
  //         .update({
  //       'totalExpense': monthlyTotal + expense.amount,
  //       'updatedTime': formattedTime,
  //     });
  //   });

  //   // } catch (e) {
  //   //   debugPrint(e.toString());
  //   //   return ResponseModel(
  //   //     status: ResponseStatus.error,
  //   //     data: '',
  //   //     message: e.toString(),
  //   //   );
  //   // }

  //   return ResponseModel(
  //       status: ResponseStatus.success, message: 'Success', data: '');
  // }

  Future<ResponseModel> addExpenseNew(
      Expense expense, int dailyTotal, int monthlyTotal) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String expenseDocId = "", recentDocId = "";
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);
    DocumentReference<Map<String, dynamic>> recentDoc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .add({
      'expenseTitle': expense.expenseTitle,
      'active': true,
      'amount': expense.amount,
      'expenseMonth': expense.expenseMonth,
      'expenseDate': expense.expenseDate,
      'expenseDay': expense.expenseDay,
      'details': expense.details,
      'createdDate': formattedTime,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
      'mode': expense.mode,
      'expenseDocId': expenseDocId,
    });

    recentDocId = recentDoc.id;
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .doc(recentDocId)
        .update({
      'recentDocId': recentDoc.id,
    });

    DocumentReference<Map<String, dynamic>> doc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .add({
      'expenseTitle': expense.expenseTitle,
      'amount': expense.amount,
      'details': expense.details,
      'mode': expense.mode,
      'createdDate': formattedTime,
      'expenseMonth': expense.expenseMonth,
      'expenseDate': expense.expenseDate,
      'expenseDay': expense.expenseDay,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
      'active': true,
    });

    expenseDocId = doc.id;
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .doc(doc.id)
        .update({
      'expenseDocId': doc.id,
    });

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .doc(recentDocId)
        .update({
      'expenseDocId': doc.id,
    });

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .set({
      'totalExpense': dailyTotal + expense.amount,
      'date': expense.expenseDate,
      'month': expense.expenseMonth,
      'day': expense.expenseDay,
      'updatedTime': formattedTime,
    });
    await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .set({
      'lastUpdateTime': formattedTime,
      'categoryName': expense.categoryName,
      'categoryId': expense.categoryId,
    });
    debugPrint('... @@ here@@@@@');
    await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .collection(kExpenseCollection)
        .doc(formattedTime)
        .set({
      'expenseTitle': expense.expenseTitle,
      'amount': expense.amount,
      'details': expense.details,
      'mode': expense.mode,
      'createdDate': formattedTime,
      'expenseMonth': expense.expenseMonth,
      'expenseDate': expense.expenseDate,
      "expenseDocId": "",
      'expenseDay': expense.expenseDay,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
      'active': true,
    });

    return ResponseModel(
        status: ResponseStatus.success, message: 'Success', data: '');
  }

  Future<ResponseModel> deleteExpense(String recentDocId, String expenseMonth,
      String expenseDate, String expenseDocId, int expenseAmount) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // debugPrint('.. @@ here  $userId $docId  $date 1');
      fireStoreInstance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kExpenseMonthsCollection)
          .doc(expenseMonth)
          .collection(expenseDate)
          .doc(expenseDate)
          .collection(kExpenseCollection)
          .doc(expenseDocId)
          .delete()
          .then((_) {
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseMonthsCollection)
            .doc(expenseMonth)
            .collection(expenseDate)
            .doc(expenseDate)
            .get()
            .then((value) {
          var totalDailyExp = value.data()!['totalExpense'];

          fireStoreInstance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kExpenseMonthsCollection)
              .doc(expenseMonth)
              .collection(expenseDate)
              .doc(expenseDate)
              .update({
            'totalExpense': totalDailyExp - expenseAmount,
          });
          fireStoreInstance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kRecentExpensesCollection)
              .doc(recentDocId)
              .delete();

          fireStoreInstance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kExpenseMonthsCollection)
              .doc(expenseMonth)
              .get()
              .then((value) {
            var totalMonthlyExp = value.data()!['totalExpense'];

            fireStoreInstance
                .collection(kUsersCollection)
                .doc(userId)
                .collection(kExpenseMonthsCollection)
                .doc(expenseMonth)
                .update({
              'totalExpense': totalMonthlyExp - expenseAmount,
            });
          });
          // for (int i = 0; i < value.docs.length; i++) {
          //   total = total + int.parse(value.docs[i]['amount'].toString());
          //   debugPrint('...@@ total 2=>>$total');
          // }
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

  Future<List<RecentExpense>> getRecentExpense() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<RecentExpense> recentExpList = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .get();
    var recentExpList1 = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in recentExpList1) {
      RecentExpense recentExpense = RecentExpense.toJson(element);
      recentExpList.add(recentExpense);
    }
    recentExpList.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return recentExpList;
  }

  Future<ResponseModel> getExpenseDetails(String userId) async {
    final DateTime now = DateTime.now();

    var date = DateFormat('dd-MM-yyyy').format(now);
    int dailyTotal = 0;
    var value1 = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(date)
        .get();

    if (value1.data() != null) {
      dailyTotal = value1.data()!['totalExpense'];
    }
    debugPrint('.. @@ dailyTotal from db : $dailyTotal');
    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString() + "." + "0");
  }

  Future<ResponseModel> addCaseIgnoreTitle(String userId) async {
    int dailyTotal = 0;
    QuerySnapshot<Map<String, dynamic>> res = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = res.docs;

    for (var i = 0; i < list.length; i++) {
      String title = list[i]['expenseTitle'].toString();
      fireStoreInstance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentExpensesCollection)
          .doc(list[i].id)
          .update({
        'expenseTitle_i': title.toLowerCase(),
      });
    }
    debugPrint('.. @@ dailyTotal from db : $dailyTotal');
    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString() + "." + "0");
  }
}
