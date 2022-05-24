import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/loading.dialog.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseController {
  addExpense(
      String expenseTitle,
      int selectedIndex,
      String expenseDetails,
      int expenseAmount,
      String categoryName,
      String month,
      String date,
      Mode selectedMode,
      BuildContext context) async {
    Loading().showLoading(context);
    List<String> title = expenseTitle.split(" ");
    var titleFirstWord = title.first;
    var capitalFirstWord = titleFirstWord[0].toUpperCase() +
        titleFirstWord.substring(1).toLowerCase();
    int dailyTotal =
        Provider.of<HomeProvider>(context, listen: false).dailyTotalExpense;
    int monthlyTotal =
        Provider.of<HomeProvider>(context, listen: false).monthlyTotalExpense;
    Expense exp = Expense(
        expenseTitle: expenseTitle,
        createdDate: "",
        expenseDocId: "",
        categoryIndex: selectedIndex,
        details: expenseDetails,
        amount: expenseAmount,
        categoryName: categoryName,
        expenseMonth: month,
        expenseDate: date,
        expenseDay: date.split('-').first,
        mode: selectedMode.toString().split('.').last);
    ResponseModel response = await UserRepo().addExpenseNew(
      exp,
      dailyTotal,
      monthlyTotal,
    );
    if (response.status == ResponseStatus.error) {
      await showOkAlertDialog(
        context: context,
        title: 'Alert',
        message: response.message,
      );
    } else {
      Provider.of<HomeProvider>(context, listen: false)
          .addToDailyExpense(expenseAmount);

      UserRepo().getRecentExpense().then((recentExpList) {
        if (recentExpList.isNotEmpty) {
          Provider.of<HomeProvider>(context, listen: false)
              .updateRecentList(recentExpList);

          Future.delayed(const Duration(seconds: 2)).then((value) {
            showOkAlertDialog(context: context, title: 'Expense Added !')
                .then((value) {
              if ((defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS)) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const HomeScreenMobile(),
                    ),
                    (r) => false);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const HomeScreenDesktop(),
                    ),
                    (r) => false);
              }
            });
          });
        }
      });
    }
  }
}