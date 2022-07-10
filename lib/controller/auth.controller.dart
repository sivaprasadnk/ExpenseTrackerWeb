import 'package:expense_tracker/api/repo/auth_repo.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/loading.dialog.dart';
import 'package:expense_tracker/utils/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class AuthController {
  static AuthRepo authRepo = AuthRepo();
  static UserRepo userRepo = UserRepo();
  static GoogleSignIn? googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );

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
          var provider = Provider.of<HomeProvider>(context, listen: false);
          provider.updateDailyTotalExpense(dailyExp);
          userRepo.getRecentExpense().then((recentExpList) {
            provider.updateRecentList(recentExpList);
            provider.updateCurrency(response.data);
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

  static void register(
    BuildContext context,
    String email,
    String password,
  ) {
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
          var provider = Provider.of<HomeProvider>(context, listen: false);
          provider.updateDailyTotalExpense(0);
          provider.updateDailyCashTotalExpense(0);
          provider.updateDailyOnlineTotalExpense(0);

          provider.updateRecentList([]);

          Navigation.checkPlatformAndNavigateToHome(context);
        }
      });
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, description: err.toString());
    }
  }

  static void googleLogin({
    required BuildContext context,
    required GoogleSignInAccount account,
    bool link = false,
    AuthCredential? authCredential,
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
          var provider = Provider.of<HomeProvider>(context, listen: false);
          int dailyExp = response.dailyTotal;
          provider.updateDailyTotalExpense(dailyExp);
          provider.updateDailyCashTotalExpense(response.dailyCashTotal);
          provider.updateDailyOnlineTotalExpense(response.dailyOnlineTotal);
          userRepo.getRecentExpense().then((recentExpList) {
            provider.updateRecentList(recentExpList);
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

  static void fbLogin(
      {required BuildContext context, required bool isMobileScreen}) async {
    try {
      // final LoginResult result = await FacebookAuth.instance.login(
      //   permissions: [
      //     "public_profile",
      //     "email",
      //   ],
      // );
      // if (result.status == LoginStatus.success) {
      //   Loading.showLoading(context);

      //   authRepo.fbLogin(result: result).then((response) async {
      //     if (response.status == ResponseStatus.error) {
      //       FirebaseAuthException exc = response.data;
      //       if (exc.code == 'account-exists-with-different-credential') {
      //         List<String> emailList = await FirebaseAuth.instance
      //             .fetchSignInMethodsForEmail(exc.email!);
      //         if (emailList.first == "google.com") {
      //           String message =
      //               "You have used 'Google sign in' option  for this account to use this app. Please select 'Sign In using Google' to login to app";
      //           Dialogs.showAlertDialog(context: context, description: message);
      //         }
      //       } else {
      //         Dialogs.showAlertDialog(
      //                 context: context, description: response.message)
      //             .then((value) {
      //           Navigator.pop(context);
      //         });
      //       }
      //     } else {
      //       var provider = Provider.of<HomeProvider>(context, listen: false);
      //       int dailyExp = response.dailyTotal;
      //       provider.updateDailyTotalExpense(dailyExp);
      //       provider.updateDailyCashTotalExpense(response.dailyCashTotal);
      //       provider.updateDailyOnlineTotalExpense(response.dailyOnlineTotal);

      //       userRepo.getRecentExpense().then((recentExpList) {
      //         Provider.of<HomeProvider>(context, listen: false)
      //             .updateRecentList(recentExpList);
      //         Navigation.checkPlatformAndNavigateToHome(context, isMobileScreen);
      //       });
      //     }
      //   });
      // } else {}
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(context: context, description: err.toString());
    }
  }
}
