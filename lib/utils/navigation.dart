import 'package:expense_tracker/view/home/home.screen.dart';
import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:flutter/cupertino.dart';

class Navigation {
  static checkPlatformAndNavigateToHome(BuildContext context,
      [bool isReplacement = false]) {
    if (!isReplacement) {
      // if (width < 480) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, HomeScreen.routeName, (r) => false);
      // } else {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, HomeScreenDesktop.routeName, (r) => false);
      // }
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (r) => false);
    } else {
      // if (isMobileScreen) {
      //   Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
      // } else {
      //   Navigator.pushReplacementNamed(context, HomeScreenDesktop.routeName);
      // }
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  static checkPlatformAndNavigateToLogin(
      {required BuildContext context}) async {
    // if ((defaultTargetPlatform == TargetPlatform.android ||
    //       defaultTargetPlatform == TargetPlatform.iOS)) {
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, LoginScreenMobile.routeName, (r) => false);
    //   } else {
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, LoginScreenDesktop.routeName, (r) => false);
    //   }

    // if (width < 480) {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, LoginScreenMobile.routeName, (r) => false);
    // } else {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, LoginScreenDesktop.routeName, (r) => false);
    // }
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (r) => false);
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
