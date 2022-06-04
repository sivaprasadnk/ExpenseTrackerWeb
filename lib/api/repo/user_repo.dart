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

  Future<ResponseModel> addExpense(Expense expense, int dailyTotal,
      int monthlyTotal, String userId, String formattedTime) async {
    String expenseDocId = "", recentDocId = "";

    /// adding recent expenses
    DocumentReference<Map<String, dynamic>> recentDoc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .add({
      'active': true,
      'expenseTitle': expense.expenseTitle,
      'expenseTitle_i': expense.expenseTitle.toLowerCase(),
      'details': expense.details,
      'details_i': expense.details.toLowerCase(),
      'amount': expense.amount,
      'amount_i': expense.amount.toString().toLowerCase(),
      'expenseMonth': expense.expenseMonth,
      'expenseMonthDocId': expense.expenseMonthDocId,
      'expenseDate': expense.expenseDate,
      'expenseDay': expense.expenseDay,
      'createdDate': formattedTime,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
      'mode': expense.mode,
      'expenseDocId': expenseDocId,
    });

    /// updating recent expense docid

    recentDocId = recentDoc.id;
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .doc(recentDocId)
        .update({
      'recentDocId': recentDoc.id,
    });

    /// adding expense for the date

    DocumentReference<Map<String, dynamic>> doc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .add({
      'expenseTitle': expense.expenseTitle,
      'expenseTitle_i': expense.expenseTitle.toLowerCase(),
      'details': expense.details,
      'details_i': expense.details.toLowerCase(),
      'amount': expense.amount,
      'amount_i': expense.amount.toString().toLowerCase(),
      'mode': expense.mode,
      'createdDate': formattedTime,
      'expenseMonth': expense.expenseMonth,
      'expenseMonthDocId': expense.expenseMonthDocId,
      'expenseDate': expense.expenseDate,
      'expenseDay': expense.expenseDay,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
      'active': true,
    });

    /// updating  expense docid &  recent docid

    expenseDocId = doc.id;
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .doc(doc.id)
        .update({
      'expenseDocId': expenseDocId,
      'recentDocId': recentDoc.id,
    });

    /// updating  expense docid in recent expense item

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .doc(recentDocId)
        .update({
      'expenseDocId': expenseDocId,
    });

    /// updating  total expense amount for the date

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

    /// setting  expense category

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

    /// setting  expense category item in category list

    await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .collection(kExpenseCollection)
        .doc(formattedTime)
        .set({
      'expenseTitle': expense.expenseTitle,
      'expenseTitle_i': expense.expenseTitle.toLowerCase(),
      'amount': expense.amount,
      'amount_i': expense.amount.toString().toLowerCase(),
      'details': expense.details,
      'details_i': expense.details.toLowerCase(),
      'mode': expense.mode,
      'createdDate': formattedTime,
      'expenseMonth': expense.expenseMonth,
      'expenseMonthDocId': expense.expenseMonthDocId,
      'expenseDate': expense.expenseDate,
      "expenseDocId": expenseDocId,
      'recentDocId': recentDoc.id,
      'expenseDay': expense.expenseDay,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
      'updatedTime': formattedTime,
      'active': true,
    });

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseMonthsCollection)
        .doc(expense.expenseMonthDocId)
        .set({
      'totalExpense': monthlyTotal + expense.amount,
      'lastUpdatedTime': formattedTime,
      'lastUpdatedExpenseDocId': expenseDocId,
    });

    return ResponseModel(
        status: ResponseStatus.success, message: 'Success', data: '');
  }

  Future<ResponseModel> deleteExpense(String recentDocId, String expenseMonth,
      String expenseDate, String expenseDocId, int expenseAmount) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

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
  }

  Future<List<RecentExpense>> getRecentExpense() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<RecentExpense> recentExpList = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .orderBy('createdDateTime', descending: true)
        .limit(4)
        .get();
    var recentExpList1 = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in recentExpList1) {
      RecentExpense recentExpense = RecentExpense.fromMap(element);
      recentExpList.add(recentExpense);
    }
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
    debugPrint('...@@ started');
    int dailyTotal = 0;
    QuerySnapshot<Map<String, dynamic>> res = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = res.docs;

    for (var i = 0; i < list.length; i++) {
      debugPrint('...@@ here @1');

      String createdDateValue =
          list[i]['createdDateTimeString'].toString().split(' ').first;
      String timeValue =
          list[i]['createdDateTimeString'].toString().split(' ').last;
      String dateValue = createdDateValue.split('-').first;
      String monthValue = createdDateValue.split('-')[1];
      String yearValue = createdDateValue.split('-').last;
      String reversedValue = yearValue + "-" + monthValue + "-" + dateValue;

      var createdDateTime = DateTime.parse(reversedValue + " " + timeValue);

      fireStoreInstance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentExpensesCollection)
          .doc(list[i].id)
          .update({
        'createdDateTime': createdDateTime,
      });
    }
    debugPrint('.. @@ dailyTotal from db : $dailyTotal');
    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString() + "." + "0");
  }
}
