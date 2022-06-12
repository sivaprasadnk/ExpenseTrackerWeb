import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/add.expense.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UserRepo {
  final fireStoreInstance = FirebaseFirestore.instance;

  Future<ResponseModel> addExpense(AddExpenseModel request) async {
    String expenseDocId = "", recentDocId = "";
    Expense expense = request.expense;

    /// adding recent expenses
    DocumentReference<Map<String, dynamic>> recentDoc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kRecentExpensesCollection)
        .add(Expense.toJson(request.expense));
    recentDocId = recentDoc.id;

    /// adding expense for the date

    DocumentReference<Map<String, dynamic>> doc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .add(Expense.toJson(request.expense));

    /// updating  expense docid &  recent docid

    expenseDocId = doc.id;
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .doc(doc.id)
        .update({
      'expenseDocId': expenseDocId,
      'recentDocId': recentDocId,
      'createdDateTime': request.createdDateTime,
      'createdDateTimeString': request.createdDateTimeString,
    });

    /// updating  expense docid in recent expense item

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kRecentExpensesCollection)
        .doc(recentDocId)
        .update({
      'expenseDocId': expenseDocId,
      'recentDocId': recentDocId,
      'createdDateTime': request.createdDateTime,
      'createdDateTimeString': request.createdDateTimeString,
    });

    /// updating  total expense amount for the date

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .set({
      'totalExpense': request.dailyTotal + expense.amount,
      'date': expense.expenseDate,
      'month': expense.expenseMonth,
      'day': expense.expenseDay,
      'monthDocId': expense.expenseMonthDocId,
      'updatedDateTime': request.createdDateTimeString,
    });

    /// setting  expense category

    await fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .set({
      'lastUpdateTime': request.createdDateTimeString,
      'categoryName': expense.categoryName,
      'categoryId': expense.categoryId,
    });

    /// setting  expense category item in category list

    await fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .collection(kExpenseCollection)
        .doc(request.createdDateTimeString)
        .set({
      'active': true,
      'amount': expense.amount,
      'amount_i': expense.amount.toString().toLowerCase(),
      'details': expense.details,
      'details_i': expense.details.toLowerCase(),
      'mode': expense.mode,
      'expenseDocId': expenseDocId,
      'recentDocId': recentDocId,
      'expenseTitle': expense.expenseTitle,
      'expenseTitle_i': expense.expenseTitle.toLowerCase(),
      'expenseMonth': expense.expenseMonth,
      'expenseMonthDocId': expense.expenseMonthDocId,
      'expenseDate': expense.expenseDate,
      'expenseDay': expense.expenseDay,
      'createdDateTime': request.createdDateTime,
      'createdDateTimeString': request.createdDateTimeString,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
    });

    /// add expense month details

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseMonthsCollection)
        .doc(expense.expenseMonthDocId)
        .set({
      'totalExpense': request.dailyTotal + expense.amount,
      'lastUpdatedTime': request.createdDateTimeString,
      'lastUpdatedExpenseDocId': expenseDocId,
      'month': request.expenseMonth.month,
      'monthDocId': request.expenseMonth.monthDocId,
      'monthOnly': request.expenseMonth.monthOnly,
      'year': request.expenseMonth.year,
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

  Future<ResponseModel> updateDbValue(String userId) async {
    debugPrint('...@@ started');
    int dailyTotal = 0;
    QuerySnapshot<Map<String, dynamic>> res = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = res.docs;

    for (var i = 0; i < list.length; i++) {
      debugPrint('...@@ here @1');

      String monthWIthComma = list[i]['month'].toString().split(' ').first;
      String yearValue = list[i]['month'].toString().split(' ').last;

      String monthWithoutComma = monthWIthComma.split(',').first;
      // String timeValue =
      //     list[i]['createdDateTimeString'].toString().split(' ').last;
      // String dateValue = createdDateValue.split('-').first;
      // String monthValue = createdDateValue.split('-')[1];
      String monthWithHyphen = monthWithoutComma + "_" + yearValue;

      // var createdDateTime = DateTime.parse(reversedValue + " " + timeValue);

      fireStoreInstance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kExpenseDatesNewCollection)
          .doc(list[i].id)
          .update({
        'monthDocId': monthWithHyphen,
      });
    }
    debugPrint('.. @@ dailyTotal from db : $dailyTotal');
    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString() + "." + "0");
  }
}
