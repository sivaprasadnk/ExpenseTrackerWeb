import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/add.expense.model.dart';
import 'package:expense_tracker/model/edit.expense.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/location.response.model.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../key.dart';

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

    DocumentSnapshot<Map<String, dynamic>> categoryDoc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .get();

    int totAmt = 0;
    if (categoryDoc.data() != null) {
      totAmt = categoryDoc.data()!['totalAmount'] ?? 0;
    } else {}

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .set({
      'totalAmount': totAmt + expense.amount,
      'lastUpdateTime': request.createdDateTimeString,
      'categoryName': expense.categoryName,
      'categoryId': expense.categoryId,
    });
    debugPrint(
        ' ${expense.categoryName} totalMount after :: ${(totAmt + expense.amount)}');

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
      status: ResponseStatus.success,
      message: 'Success',
      data: '',
    );
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
        });
      });
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
      dailyTotal = value1.data()!['totalExpense'] as int;
    }
    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString() + "." + "0");
  }

  Future<ResponseModel> updateDbValue(String userId) async {
    int dailyTotal = 0;
    QuerySnapshot<Map<String, dynamic>> res = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = res.docs;

    for (var i = 0; i < list.length; i++) {
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
    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString() + "." + "0");
  }

  Future<LocationResponseModel> getLocationDetails() async {
    LocationResponseModel model;
    final String url = 'https://ipapi.co/json/?key=$key';
    final uri = Uri.parse(url);
    var response = await Dio().getUri(uri, options: Options(headers: {}));

    final Map<String, dynamic> responseData = response.data;

    model = LocationResponseModel.fromJson(responseData);

    return model;
  }

  Future<ResponseModel> editExpense(EditExpenseModel model) async {
    var userId = model.userId;
    var expense = model.expense;

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .doc(expense.recentDocId)
        .update(
          Expense.toJson(expense),
        );

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .collection(kExpenseCollection)
        .doc(expense.expenseDocId)
        .update(
          Expense.toJson(expense),
        );
    debugPrint('.. model.newDateWiseTotal : ${model.newDateWiseTotal}');
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .update({
      'totalExpense': model.newDateWiseTotal,
      'updatedDateTime': model.updateDateTimeString,
    });

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .update({
      'totalAmount': model.newCategoryWiseTotal,
      'lastUpdateTime': model.updateDateTimeString,
    });

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .collection(kExpenseCollection)
        .doc(expense.createdDateTimeString)
        .update(Expense.toJson(expense));

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
      dailyTotal = value1.data()!['totalExpense'] as int;
    }

    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString());
  }

  Future<int> getDatewiseTotalAmount(
      {required String userId, required Expense expense}) async {
    int totExpAmt = 0;
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(expense.expenseDate)
        .get();

    if (docSnapshot.data() != null) {
      Map doc = docSnapshot.data()!;

      totExpAmt = doc['totalExpense'];
    }
    return totExpAmt;
  }

  Future<int> getCategorywiseTotalAmount(
      {required String userId, required Expense expense}) async {
    var docSnapshot = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .get();

    var doc = docSnapshot.data();

    int totExpAmt = doc!['totalAmount'];
    return totExpAmt;
  }
}
