import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/add.transaction.model.dart';
import 'package:expense_tracker/model/edit.expense.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/utils/loading.dialog.dart';
import 'package:expense_tracker/utils/navigation.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/transaction.model.dart';

class UserController {
  static UserRepo userRepo = UserRepo();

  static void addExpense(
      int categoryId,
      String categoryName,
      int expenseAmount,
      String expenseTitle,
      String expenseDetails,
      Mode selectedMode,
      DateTime selectedDate,
      BuildContext context) async {
    Loading.showLoading(context);
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // var date = DateFormat('dd-MM-yyyy').format(selectedDate);
    // var month = DateFormat('MMM, yyyy').format(selectedDate);
    // var monthOnly = DateFormat('MMM').format(selectedDate);
    // var monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
    // final DateTime now = DateTime.now();
    // var a = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    // var createdDateTime = DateTime.parse(a);

    // final String createdDateTimeString =
    //     DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);

    // final year = int.parse(DateFormat('yyyy').format(now));

    // var provider = Provider.of<HomeProvider>(context, listen: false);

    // int dailyTotal = provider.dailyTotalExpense;
    // int dailyCashTotal = provider.dailyCashTotal;
    // int dailyOnlineTotal = provider.dailyOnlineTotal;

    // ///
    // Expense exp = Expense(
    //   expenseTitle: expenseTitle,
    //   createdDateTimeString: "",
    //   expenseDocId: "",
    //   recentDocId: "",
    //   categoryId: categoryId,
    //   details: expenseDetails,
    //   expenseMonthDocId: monthDocId,
    //   amount: expenseAmount,
    //   categoryName: categoryName,
    //   expenseMonth: month,
    //   expenseDate: date,
    //   expenseDay: date.split('-').first,
    //   mode: selectedMode.toString().split('.').last.initCap(),
    // );

    // ExpenseMonth expMonth = ExpenseMonth(
    //   year: year,
    //   month: month,
    //   monthOnly: monthOnly,
    //   monthDocId: monthDocId,
    // );
    // var request = AddExpenseModel(
    //   expense: exp,
    //   dailyTotal: dailyTotal,
    //   dailyCashTotal: dailyCashTotal,
    //   dailyOnlineTotal: dailyOnlineTotal,
    //   userId: userId,
    //   createdDateTimeString: createdDateTimeString,
    //   expenseMonth: expMonth,
    //   createdDateTime: createdDateTime,
    // );

    // ResponseModel response = await userRepo.addExpense(request);

    // if (response.status == ResponseStatus.error) {
    //   Dialogs.showAlertDialog(context: context, description: response.message);
    // } else {
    //   var provider = Provider.of<HomeProvider>(context, listen: false);

    //   provider.addToDailyExpense(expenseAmount);
    //   if (selectedMode == Mode.cash) {
    //     provider.addToDailyCashExpense(expenseAmount);
    //   } else {
    //     provider.addToDailyOnlineExpense(expenseAmount);
    //   }

    //   userRepo.getRecentExpense().then((recentExpList) {
    //     if (recentExpList.isNotEmpty) {
    //       provider.updateRecentList(recentExpList);

    //       Future.delayed(const Duration(seconds: 2)).then((value) {
    //         Dialogs.showAlertDialogAndNavigateToHome(
    //             context: context, description: 'Expense Added !');
    //       });
    //     }
    //   });
    // }
  }

  static void getExpenseDetailsAndNavigateToHome(
      BuildContext context, String userId, double width) async {
    Loading.showLoading(context);

    ResponseModel response = await userRepo.getExpenseDetails(userId);
    String responseData = response.data;
    String dailyExpString = responseData.split('.').first;
    int dailyExp = int.parse(dailyExpString);
    var provider = Provider.of<HomeProvider>(context, listen: false);
    provider.updateDailyTotalExpense(dailyExp);
    userRepo.getRecentExpense().then((recentExpList) {
      provider.updateRecentList(recentExpList);
      Navigation.checkPlatformAndNavigateToHome(context, true);
    });
  }

  static void editExpense(
      {required Expense existingExpense,
      required Expense newExpense,
      required BuildContext context}) async {
    try {
      if (existingExpense.expenseDocId.isEmpty) {
        throw CustomException(' expenseDocId empty !');
      }

      if (existingExpense.recentDocId.isEmpty) {
        throw CustomException(' recentDocId empty !');
      }
      if (existingExpense.createdDateTimeString.isEmpty) {
        throw CustomException(' createdDateTimeString empty !');
      }
      Loading.showLoading(context);

      String userId = FirebaseAuth.instance.currentUser!.uid;

      int currentDatewiseTotal = await userRepo.getDatewiseTotalAmount(
          userId: userId, expense: existingExpense);

      var amtToAdd = newExpense.amount - existingExpense.amount;
      amtToAdd = newExpense.amount - existingExpense.amount;

      int currentCategorywiseTotal = await userRepo.getCategorywiseTotalAmount(
          userId: userId, expense: existingExpense);

      var newDateWiseTotal = currentDatewiseTotal + amtToAdd;
      var newCategoryWiseTotal = currentCategorywiseTotal + amtToAdd;

      final DateTime now = DateTime.now();

      var a = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
      final String updateDateTimeString =
          DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);
      var updateDateTime = DateTime.parse(a);

      EditExpenseModel model = EditExpenseModel(
        newDateWiseTotal: newDateWiseTotal,
        newCategoryWiseTotal: newCategoryWiseTotal,
        expense: newExpense,
        userId: userId,
        updateDateTime: updateDateTime,
        updateDateTimeString: updateDateTimeString,
      );
      ResponseModel response = await userRepo.editExpense(model);
      if (response.status == ResponseStatus.error) {
        Dialogs.showAlertDialog(
            context: context, description: response.message);
      } else {
        var total = int.parse(response.data);
        var provider = Provider.of<HomeProvider>(context, listen: false);
        provider.updateDailyTotalExpense(total);
        userRepo.getRecentExpense().then((recentExpList) {
          provider.updateRecentList(recentExpList);
          Future.delayed(const Duration(seconds: 2)).then((value) {
            Dialogs.showAlertDialogAndNavigateToHome(
                context: context, description: 'Expense updated !');
          });
        });
      }
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, description: err.toString());
    }
  }

  ///

  static void addTransaction(
    int categoryId,
    String categoryName,
    int amount,
    String title,
    String details,
    TransactionType selectedType,
    DateTime selectedDate,
    BuildContext context,
  ) async {
    Loading.showLoading(context);
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var date = DateFormat('dd-MM-yyyy').format(selectedDate);
    var month = DateFormat('MMM, yyyy').format(selectedDate);
    var monthOnly = DateFormat('MMM').format(selectedDate);
    var monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
    final DateTime now = DateTime.now();
    var a = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    var createdDateTime = DateTime.parse(a);

    final String createdDateTimeString =
        DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);

    final year = int.parse(DateFormat('yyyy').format(now));

    var provider = Provider.of<HomeProvider>(context, listen: false);

    int monthlyTotalIncome = provider.monthlyTotalIncome;
    int monthlyTotalExpense = provider.monthlyTotalExpense;


    TransactionModel trans = TransactionModel(
      title: title,
      createdDateTime: createdDateTime,
      createdDateTimeString: createdDateTimeString,
      transactionDocId: "",
      recentDocId: "",
      categoryId: categoryId,
      details: details,
      transactionMonthDocId: monthDocId,
      amount: amount,
      categoryName: categoryName,
      transactionMonth: month,
      transactionDate: date,
      transactionDay: date.split('-').first,
      transactionType: selectedType.toString().split('.').last.initCap(),
    );

    TransactionMonth transactionMonth = TransactionMonth(
      year: year,
      month: month,
      monthOnly: monthOnly,
      monthDocId: monthDocId,
    );


    var request = AddTransactionModel(
      transaction: trans,
      userId: userId,
      transactionMonth: transactionMonth,
      monthlyTotalIncome: monthlyTotalIncome,
      monthlyTotalExpense: monthlyTotalExpense,
      createdDateTimeString: createdDateTimeString,
      createdDateTime: createdDateTime,
    );

    ResponseModel response = await userRepo.addTransaction(request);

    if (response.status == ResponseStatus.error) {
      Dialogs.showAlertDialog(context: context, description: response.message);
    } else {
      var provider = Provider.of<HomeProvider>(context, listen: false);

      if (selectedType == TransactionType.income) {
        provider.addToDailyTotalIncome(amount);
        provider.addToMonthlyTotalIncome(amount);
      } else {
        provider.addToDailyTotalExpense(amount);
        provider.addToMonthlyTotalExpense(amount);
      }

      userRepo.getRecentTransaction().then((recentList) {
        if (recentList.isNotEmpty) {
          provider.updateRecentList(recentList);

          Future.delayed(const Duration(seconds: 2)).then((value) {
            Dialogs.showAlertDialogAndNavigateToHome(
                context: context, description: 'Transaction Added !');
          });
        }
      });
    }
  }
}
