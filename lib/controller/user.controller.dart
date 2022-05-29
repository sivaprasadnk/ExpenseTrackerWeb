import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/auth_repo.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/loading.dialog.dart';
import 'package:expense_tracker/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserController {
  static UserRepo userRepo = UserRepo();
  static AuthRepo authRepo = AuthRepo();

  static void login(BuildContext context, String email, String password) {
    Loading.showLoading(context);
    authRepo.loginNew(email, password).then((response) async {
      if (response.status == ResponseStatus.error) {
        await showOkAlertDialog(
          context: context,
          title: 'Alert',
          message: response.message,
        ).then((value) {
          Navigator.pop(context);
        });
      } else {
        // Provider.of<AuthProvider>(context, listen: false).setUserStatus(true);
        String responseData = response.data;
        String dailyExpString = responseData.split('.').first;
        int dailyExp = int.parse(dailyExpString);
        Provider.of<HomeProvider>(context, listen: false)
            .updateDailyTotalExpense(dailyExp);
        UserRepo().getRecentExpense().then((recentExpList) {
          Provider.of<HomeProvider>(context, listen: false)
              .updateRecentList(recentExpList);

          Navigation.checkPlatformAndNavigateToHome(context);
        });
      }
    });
  }

  static void register(BuildContext context, String email, String password) {
    Loading.showLoading(context);
    authRepo.createAccount(email, password).then((response) async {
      if (response.status == ResponseStatus.error) {
        await showOkAlertDialog(
          context: context,
          title: 'Alert',
          message: response.message,
        ).then((value) {
          Navigator.pop(context);
        });
      } else {
        Provider.of<HomeProvider>(context, listen: false)
            .updateDailyTotalExpense(0);
        Provider.of<HomeProvider>(context, listen: false).updateRecentList([]);

        Navigation.checkPlatformAndNavigateToHome(context);
      }
    });
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
