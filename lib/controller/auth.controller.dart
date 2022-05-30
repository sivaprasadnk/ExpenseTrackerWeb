import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/auth_repo.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/loading.dialog.dart';
import 'package:expense_tracker/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class AuthController {
  static AuthRepo authRepo = AuthRepo();

  static void login(BuildContext context, String email, String password) {
    try {
      if (email.isEmpty) {
        throw CustomException('Enter email !');
      }
      if (!isEmail(email)) {
        throw CustomException('Enter proper email !');
      }
      if (password.isEmpty) {
        throw CustomException('Enter password !');
      }

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
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, title: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, title: err.toString());
    }
  }

  static void register(BuildContext context, String email, String password) {
    try {
      if (email.isEmpty) {
        throw CustomException('Enter email !');
      }
      if (!isEmail(email)) {
        throw CustomException('Enter proper email !');
      }
      if (password.isEmpty) {
        throw CustomException('Enter password !');
      }

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
          Provider.of<HomeProvider>(context, listen: false)
              .updateRecentList([]);

          Navigation.checkPlatformAndNavigateToHome(context);
        }
      });
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, title: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, title: err.toString());
    }
  }
}
