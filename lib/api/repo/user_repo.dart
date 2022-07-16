import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/add.expense.model.dart';
import 'package:expense_tracker/model/add.transaction.model.dart';
import 'package:expense_tracker/model/edit.expense.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/get.balances.response.dart';
import 'package:expense_tracker/model/location.response.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:expense_tracker/model/transaction.model.dart';
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
      // 'totalCashExpense': expense.mode == "Cash"
      //     ? request.dailyCashTotal + expense.amount
      //     : request.dailyCashTotal,
      // 'totalOnlineExpense': expense.mode == "Online"
      //     ? request.dailyOnlineTotal + expense.amount
      //     : request.dailyOnlineTotal,
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
    int totCashAmt = 0;
    int totOnlineAmt = 0;
    if (categoryDoc.data() != null) {
      totAmt = categoryDoc.data()!['totalAmount'] ?? 0;
      totCashAmt = categoryDoc.data()!['totalCashAmount'] ?? 0;
      totOnlineAmt = categoryDoc.data()!['totalOnlineAmount'] ?? 0;
    } else {}

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kExpenseCategoriesCollection)
        .doc(expense.categoryName)
        .set({
      'totalAmount': totAmt + expense.amount,
      // 'totalCashAmount':
      //     expense.mode == "Cash" ? totCashAmt + expense.amount : totCashAmt,
      // 'totalOnlineAmount': expense.mode == "Online"
      //     ? totOnlineAmt + expense.amount
      //     : totOnlineAmt,
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
      // 'mode': expense.mode,
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

  Future<List<TransactionModel>> getRecentTransactions() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<TransactionModel> recentExpList = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .orderBy('createdDateTime', descending: true)
        .limit(5)
        .get();
    var recentTransactionList1 =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in recentTransactionList1) {
      TransactionModel recentExpense = TransactionModel.fromMap(element);
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

  Future<ResponseModel> addTransaction(AddTransactionModel request) async {
    String transactionDocId = "", recentDocId = "";
    debugPrint(".. @1");
    TransactionModel transaction = request.transaction;

    /// adding recent expenses
    DocumentReference<Map<String, dynamic>> recentDoc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kRecentTransactionCollection)
        .add(TransactionModel.toJson(transaction));
    recentDocId = recentDoc.id;
    debugPrint(".. @2");

    /// adding expense for the date

    DocumentReference<Map<String, dynamic>> doc = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kTransactionDatesCollection)
        .doc(transaction.transactionDate)
        .collection(kTransactionCollection)
        .add(TransactionModel.toJson(transaction));
    debugPrint(".. @3");

    /// updating  expense docid &  recent docid

    transactionDocId = doc.id;
    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kTransactionDatesCollection)
        .doc(transaction.transactionDate)
        .collection(kTransactionCollection)
        .doc(transactionDocId)
        .update({
      kTransactionDocIdField: transactionDocId,
      kRecentDocIdField: recentDocId,
      kCreatedDateTimeField: request.createdDateTime,
      'createdDateTimeString': request.createdDateTimeString,
    });
    debugPrint(".. @4");

    /// updating  expense docid in recent expense item

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kRecentTransactionCollection)
        .doc(recentDocId)
        .update({
      kTransactionDocIdField: transactionDocId,
      kRecentDocIdField: recentDocId,
      'dailyDrOrCr': request.dailyDrOrCr,
      kCreatedDateTimeField: request.createdDateTime,
      'createdDateTimeString': request.createdDateTimeString,
    });
    debugPrint(".. @5");

    /// updating  total expense amount for the date

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kTransactionDatesCollection)
        .doc(transaction.transactionDate)
        .set({
      kDailyTotalIncomeField: request.dailyTotalIncome,
      kDailyTotalExpenseField: request.dailyTotalExpense,
      kDailyBalanceField: request.dailyTotalIncome - request.dailyTotalExpense,
      "day": transaction.transactionDay,
      'date': transaction.transactionDate,
      'month': transaction.transactionMonth,
      'monthDocId': transaction.transactionMonthDocId,
      'updatedDateTime': request.createdDateTime,
      kDailyDrOrCrField: request.dailyDrOrCr,
      'monthlyDrOrCr': request.monthlyDrOrCr,
      'updatedDateTimeString': request.createdDateTimeString,
    });
    debugPrint(".. @6");

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kTransactionMonthsCollection)
        .doc(transaction.transactionMonthDocId)
        .set({
      'year': request.transactionMonth.year,
      'month': request.transactionMonth.month,
      'monthDocId': request.transactionMonth.monthDocId,
      'monthOnly': request.transactionMonth.monthOnly,
      kMonthlyTotalIncomeField: request.monthlyTotalIncome,
      kMonthlyTotalExpenseField: request.monthlyTotalExpense,
      kMonthlyBalanceField:
          request.monthlyTotalIncome - request.monthlyTotalExpense,
      kMonthlyDrOrCrField: request.monthlyDrOrCr,
      kCreatedDateTimeField: request.createdDateTime,
      'updatedDateTimeString': request.createdDateTimeString,
    });
    debugPrint(".. @7");

    fireStoreInstance
        .collection(kUsersCollection)
        .doc(request.userId)
        .collection(kTransactionDatesCollection)
        .doc(transaction.transactionDate)
        .collection(kTransactionCategoriesCollection)
        .doc(transaction.categoryName)
        .collection(kTransactionCollection)
        .doc(request.createdDateTimeString)
        .set({
      'active': true,
      'amount': transaction.amount,
      'amount_i': transaction.amount.toString().toLowerCase(),
      'details': transaction.details,
      'details_i': transaction.details.toLowerCase(),
      'transactionType': transaction.transactionType,
      'transactionDocId': transactionDocId,
      'recentDocId': recentDocId,
      'title': transaction.title,
      'title_i': transaction.title.toLowerCase(),
      'transactionMonth': transaction.transactionMonth,
      'transactionMonthDocId': transaction.transactionMonthDocId,
      'transactionDate': transaction.transactionDate,
      'transactionDay': transaction.transactionDay,
      'createdDateTime': request.createdDateTime,
      'createdDateTimeString': request.createdDateTimeString,
      'categoryId': transaction.categoryId,
      'categoryName': transaction.categoryName,
    });
    debugPrint(".. @8");
    // DocumentSnapshot<Map<String, dynamic>> categoryDoc = await fireStoreInstance
    //     .collection(kUsersCollection)
    //     .doc(request.userId)
    //     .collection(kExpenseCategoriesCollection)
    //     .doc(expense.categoryName)
    //     .get();

    // int totAmt = 0;
    // int totCashAmt = 0;
    // int totOnlineAmt = 0;
    // if (categoryDoc.data() != null) {
    //   totAmt = categoryDoc.data()!['totalAmount'] ?? 0;
    //   totCashAmt = categoryDoc.data()!['totalCashAmount'] ?? 0;
    //   totOnlineAmt = categoryDoc.data()!['totalOnlineAmount'] ?? 0;
    // } else {}

    // fireStoreInstance
    //     .collection(kUsersCollection)
    //     .doc(request.userId)
    //     .collection(kExpenseCategoriesCollection)
    //     .doc(expense.categoryName)
    //     .set({
    //   'totalAmount': totAmt + expense.amount,
    //   'totalCashAmount':
    //       expense.mode == "Cash" ? totCashAmt + expense.amount : totCashAmt,
    //   'totalOnlineAmount': expense.mode == "Online"
    //       ? totOnlineAmt + expense.amount
    //       : totOnlineAmt,
    //   'lastUpdateTime': request.createdDateTimeString,
    //   'categoryName': expense.categoryName,
    //   'categoryId': expense.categoryId,
    // });

    // /// setting  expense category item in category list

    // await fireStoreInstance
    //     .collection(kUsersCollection)
    //     .doc(request.userId)
    //     .collection(kExpenseCategoriesCollection)
    //     .doc(expense.categoryName)
    //     .collection(kExpenseCollection)
    //     .doc(request.createdDateTimeString)
    //     .set({
    //   'active': true,
    //   'amount': expense.amount,
    //   'amount_i': expense.amount.toString().toLowerCase(),
    //   'details': expense.details,
    //   'details_i': expense.details.toLowerCase(),
    //   'mode': expense.mode,
    //   'expenseDocId': expenseDocId,
    //   'recentDocId': recentDocId,
    //   'expenseTitle': expense.expenseTitle,
    //   'expenseTitle_i': expense.expenseTitle.toLowerCase(),
    //   'expenseMonth': expense.expenseMonth,
    //   'expenseMonthDocId': expense.expenseMonthDocId,
    //   'expenseDate': expense.expenseDate,
    //   'expenseDay': expense.expenseDay,
    //   'createdDateTime': request.createdDateTime,
    //   'createdDateTimeString': request.createdDateTimeString,
    //   'categoryId': expense.categoryId,
    //   'categoryName': expense.categoryName,
    // });

    // /// add expense month details

    // fireStoreInstance
    //     .collection(kUsersCollection)
    //     .doc(request.userId)
    //     .collection(kExpenseMonthsCollection)
    //     .doc(expense.expenseMonthDocId)
    //     .set({
    //   'totalExpense': request.dailyTotal + expense.amount,
    //   'lastUpdatedTime': request.createdDateTimeString,
    //   'lastUpdatedExpenseDocId': expenseDocId,
    //   'month': request.expenseMonth.month,
    //   'monthDocId': request.expenseMonth.monthDocId,
    //   'monthOnly': request.expenseMonth.monthOnly,
    //   'year': request.expenseMonth.year,
    // });

    return ResponseModel(
      status: ResponseStatus.success,
      message: 'Success',
      data: '',
    );
  }

  Future<GetBalancesResponse> getCurrentBalances(
      {required String userId}) async {
    final DateTime now = DateTime.now();
    int monthlyTotalIncome = 0;
    int monthlyTotalExpense = 0;
    int monthlyBalance = 0;
    String monthlyDrOrCr = "+";

    int dailyTotalIncome = 0;
    int dailyTotalExpense = 0;
    int dailyBalance = 0;
    String dailyDrOrCr = "+";

    var date = DateFormat('dd-MM-yyyy').format(now);

    // var month = DateFormat('MMM_yyyy').format(now);
    var monthDocId = DateFormat('MMM_yyyy').format(now);
    debugPrint(".. @9");

    DocumentSnapshot<Map<String, dynamic>> monthDocSnapshot =
        await fireStoreInstance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kTransactionMonthsCollection)
            .doc(monthDocId)
            .get();
    debugPrint(".. @10");
    if (monthDocSnapshot.data() != null) {
      var monthDocData = monthDocSnapshot.data()!;
      monthlyTotalIncome = monthDocData[kMonthlyTotalIncomeField];
      monthlyTotalExpense = monthDocData[kMonthlyTotalExpenseField];
      monthlyBalance = monthDocData[kMonthlyBalanceField];
      monthlyDrOrCr = monthDocData[kMonthlyDrOrCrField];

      // var monthlyTotalIncome
    }
    debugPrint(".. @11");
    DocumentSnapshot<Map<String, dynamic>> dateDocSnapshot =
        await fireStoreInstance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kTransactionDatesCollection)
            .doc(date)
            .get();
    debugPrint(".. @12");
    if (dateDocSnapshot.data() != null) {
      var dateDocData = dateDocSnapshot.data()!;
      dailyTotalIncome = dateDocData[kDailyTotalIncomeField];
      dailyTotalExpense = dateDocData[kDailyTotalExpenseField];
      dailyBalance = dateDocData[kDailyBalanceField];
      dailyDrOrCr = dateDocData[kDailyDrOrCrField];
    }
    debugPrint(".. @13");

    List<TransactionModel> recentExpList = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentTransactionCollection)
        .where('transactionDate', isEqualTo: date)
        .orderBy('createdDateTime', descending: true)
        .limit(5)
        .get();
    debugPrint(".. @14  date : $date");
    var recentTransactionList1 =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in recentTransactionList1) {
      TransactionModel recentExpense = TransactionModel.fromMap(element);
      recentExpList.add(recentExpense);
    }

    debugPrint('.. @@  $recentExpList');

    return GetBalancesResponse(
      status: ResponseStatus.success,
      message: 'Success',
      data: '',
      monthlyBalance: monthlyBalance,
      monthlyDrOrCr: monthlyDrOrCr,
      monthlyTotalIncome: monthlyTotalIncome,
      dailyBalance: dailyBalance,
      dailyDrOrCr: dailyDrOrCr,
      dailyTotalExpense: dailyTotalExpense,
      dailyTotalIncome: dailyTotalIncome,
      monthlyTotalExpense: monthlyTotalExpense,
      recentExpList: recentExpList,
      userId: userId,
    );
  }
}
