import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/add.expense.model.dart';
import 'package:expense_tracker/model/edit.expense.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/expense.month.model.dart';
import 'package:expense_tracker/model/response.model.dart';
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

    var date = DateFormat('dd-MM-yyyy').format(selectedDate);
    var month = DateFormat('MMM, yyyy').format(selectedDate);
    var monthOnly = DateFormat('MMM').format(selectedDate);
    var monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
    final DateTime now = DateTime.now();
    var a = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    var createdDateTime = DateTime.parse(a);

    final String createdDateTimeString = DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);

    final year = int.parse(DateFormat('yyyy').format(now));
    int dailyTotal =
        Provider.of<HomeProvider>(context, listen: false).dailyTotalExpense;

    ///
    Expense exp = Expense(
      expenseTitle: expenseTitle,
      createdDateTimeString: "",
      expenseDocId: "",
      recentDocId: "",
      categoryId: categoryId,
      details: expenseDetails,
      expenseMonthDocId: monthDocId,
      amount: expenseAmount,
      categoryName: categoryName,
      expenseMonth: month,
      expenseDate: date,
      expenseDay: date.split('-').first,
      mode: selectedMode.toString().split('.').last.initCap(),
    );

    ExpenseMonth expMonth = ExpenseMonth(
      year: year,
      month: month,
      monthOnly: monthOnly,
      monthDocId: monthDocId,
    );
    var request = AddExpenseModel(
      expense: exp,
      dailyTotal: dailyTotal,
      userId: userId,
      createdDateTimeString: createdDateTimeString,
      expenseMonth: expMonth,
      createdDateTime: createdDateTime,
    );

    ResponseModel response = await userRepo.addExpense(request);

    if (response.status == ResponseStatus.error) {
      Dialogs.showAlertDialog(context: context, description: response.message);
    } else {
      Provider.of<HomeProvider>(context, listen: false)
          .addToDailyExpense(expenseAmount);

      userRepo.getRecentExpense().then((recentExpList) {
        if (recentExpList.isNotEmpty) {
          Provider.of<HomeProvider>(context, listen: false)
              .updateRecentList(recentExpList);

          Future.delayed(const Duration(seconds: 2)).then((value) {
            Dialogs.showAlertDialogAndNavigateToHome(
                context: context, description: 'Expense Added !');
          });
        }
      });
    }
  }

  static void getExpenseDetails(BuildContext context, String userId) async {
    Loading.showLoading(context);

    ResponseModel response = await userRepo.getExpenseDetails(userId);
    String responseData = response.data;
    String dailyExpString = responseData.split('.').first;
    int dailyExp = int.parse(dailyExpString);
    Provider.of<HomeProvider>(context, listen: false)
        .updateDailyTotalExpense(dailyExp);
    userRepo.getRecentExpense().then((recentExpList) {
      Provider.of<HomeProvider>(context, listen: false)
          .updateRecentList(recentExpList);
      Navigation.checkPlatformAndNavigateToHome(context, true);
    });
  }

   static void editExpense(
      {required Expense expense, required BuildContext context}) async {
    try {
      if (expense.expenseDocId.isEmpty) {
        throw CustomException(' expenseDocId empty !');
      }

      if (expense.recentDocId.isEmpty) {
        throw CustomException(' recentDocId empty !');
      }
      String userId = FirebaseAuth.instance.currentUser!.uid;

      final DateTime now = DateTime.now();

      var a = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
      var updateDateTime = DateTime.parse(a);
      final String updateDateTimeString =
          DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);
      EditExpenseModel model = EditExpenseModel(
          expense: expense,
          userId: userId,
          updateDateTime: updateDateTime,
          updateDateTimeString: updateDateTimeString);
      userRepo.editExpense(model);
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, description: err.toString());
    }
  }
}
