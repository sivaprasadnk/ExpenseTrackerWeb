import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/add.expense.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/expense.month.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
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
      String expenseTitle,
      int categoryId,
      String expenseDetails,
      int expenseAmount,
      String categoryName,
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

    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);

    final year = int.parse(DateFormat('yyyy').format(now));
    int dailyTotal =
        Provider.of<HomeProvider>(context, listen: false).dailyTotalExpense;

    ///
    Expense exp = Expense(
      expenseTitle: expenseTitle,
      createdDate: "",
      expenseDocId: "",
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
      createdDateTimeString: formattedTime,
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
}
