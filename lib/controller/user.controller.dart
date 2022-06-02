import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/expense.model.dart';
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
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm:ss').format(now);
    // List<String> title = expenseTitle.split(" ");
    // var titleFirstWord = title.first;
    // var capitalFirstWord = titleFirstWord[0].toUpperCase() +
    //     titleFirstWord.substring(1).toLowerCase();
    int dailyTotal =
        Provider.of<HomeProvider>(context, listen: false).dailyTotalExpense;
    int monthlyTotal =
        Provider.of<HomeProvider>(context, listen: false).monthlyTotalExpense;
    Expense exp = Expense(
      expenseTitle: expenseTitle,
      createdDate: "",
      expenseDocId: "",
      categoryId: categoryId,
      details: expenseDetails,
      amount: expenseAmount,
      categoryName: categoryName,
      expenseMonth: month,
      expenseDate: date,
      expenseDay: date.split('-').first,
      mode: selectedMode.toString().split('.').last.initCap(),
    );

    ResponseModel response = await userRepo.addExpense(
        exp, dailyTotal, monthlyTotal, userId, formattedTime);

    if (response.status == ResponseStatus.error) {
      Dialogs.showAlertDialog(context: context, title: response.message);
    } else {
      Provider.of<HomeProvider>(context, listen: false)
          .addToDailyExpense(expenseAmount);

      userRepo.getRecentExpense().then((recentExpList) {
        if (recentExpList.isNotEmpty) {
          Provider.of<HomeProvider>(context, listen: false)
              .updateRecentList(recentExpList);

          Future.delayed(const Duration(seconds: 2)).then((value) {
            showOkAlertDialog(context: context, title: 'Expense Added !')
                .then((value) {
              Navigation.checkPlatformAndNavigateToHome(context);
            });
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
    UserRepo().getRecentExpense().then((recentExpList) {
      Provider.of<HomeProvider>(context, listen: false)
          .updateRecentList(recentExpList);
      Navigation.checkPlatformAndNavigateToHome(context, true);
    });
  }
}
