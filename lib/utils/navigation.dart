import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Navigation {
  static checkPlatformAndNavigateToHome(BuildContext context,
      [bool isReplacement = false]) {
    if (!isReplacement) {
      if ((defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreenMobile.routeName, (r) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreenDesktop.routeName, (r) => false);
      }
    } else {
      if ((defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
        Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
      } else {
        Navigator.pushReplacementNamed(context, HomeScreenDesktop.routeName);
      }
    }
  }

  // static checkPlatformAndNavigateToScreen(
  //     BuildContext context, String routeName,
  //     [bool isReplacement = false]) {
  //   if (isReplacement) {
  //     if ((defaultTargetPlatform == TargetPlatform.android ||
  //         defaultTargetPlatform == TargetPlatform.iOS)) {
  //       Navigator.pushNamed(context, routeName);
  //     } else {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, HomeScreenDesktop.routeName, (r) => false);
  //     }
  //   } else {
  //     if ((defaultTargetPlatform == TargetPlatform.android ||
  //         defaultTargetPlatform == TargetPlatform.iOS)) {
  //       Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
  //     } else {
  //       Navigator.pushReplacementNamed(context, HomeScreenDesktop.routeName);
  //     }
  //   }
  // }
}