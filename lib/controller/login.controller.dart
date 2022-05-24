import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/auth_repo.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/loading.dialog.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserController {
  static void login(BuildContext context, String email, String password) {
    Loading().showLoading(context);
    AuthRepo().loginNew(email, password).then((response) async {
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
      }
    });
  }

  static void register(BuildContext context, String email, String password) {
    Loading().showLoading(context);
    AuthRepo().createAccount(email, password).then((response) async {
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
        // UserRepo().getRecentExpense().then((recentExpList) {

        // });
      }
    });
  }
}
