import 'package:expense_tracker/api/repo/auth_repo.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/loading.dialog.dart';
import 'package:expense_tracker/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class AuthController {
  static AuthRepo authRepo = AuthRepo();
  static UserRepo userRepo = UserRepo();

  static void login(BuildContext context, String email, String password) async {
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
      var model = await userRepo.getLocationDetails();

      authRepo.loginNew(email, password, model).then((response) async {
        if (response.status == ResponseStatus.error) {
          Dialogs.showAlertDialog(
                  context: context, description: response.message)
              .then((value) {
            Navigator.pop(context);
          });
        } else {
          int dailyExp = response.dailyTotal;
          Provider.of<HomeProvider>(context, listen: false)
              .updateDailyTotalExpense(dailyExp);
          userRepo.getRecentExpense().then((recentExpList) {
            Provider.of<HomeProvider>(context, listen: false)
                .updateRecentList(recentExpList);
            Provider.of<HomeProvider>(context, listen: false)
                .updateCurrency(response.data);
            // userRepo.updateDbValue(response.userId).then((value) {
            //   Navigation.checkPlatformAndNavigateToHome(context);
            // });
            Navigation.checkPlatformAndNavigateToHome(context);
          });
        }
      });
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, description: err.toString());
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
          Dialogs.showAlertDialog(
                  context: context, description: response.message)
              .then((value) {
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
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, description: err.toString());
    }
  }

  static void googleSignIn({
    required BuildContext context,
    required GoogleSignInAccount account,
  }) {
    try {
      Loading.showLoading(context);

      authRepo.googleSignIn(account).then((response) async {
        if (response.status == ResponseStatus.error) {
          Dialogs.showAlertDialog(
                  context: context, description: response.message)
              .then((value) {
            Navigator.pop(context);
          });
        } else {
          int dailyExp = response.dailyTotal;
          Provider.of<HomeProvider>(context, listen: false)
              .updateDailyTotalExpense(dailyExp);
          userRepo.getRecentExpense().then((recentExpList) {
            Provider.of<HomeProvider>(context, listen: false)
                .updateRecentList(recentExpList);
            // userRepo.updateDbValue(response.userId).then((value) {
            //   Navigation.checkPlatformAndNavigateToHome(context);
            // });
            Navigation.checkPlatformAndNavigateToHome(context);
          });
        }
      });
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, description: err.toString());
    }
  }
}
