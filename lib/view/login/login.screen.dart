import 'package:expense_tracker/utils/responsive.screen.dart';
import 'package:expense_tracker/view/login/login.screen.desktop.dart';
import 'package:expense_tracker/view/login/login.screen.mobile.dart';
import 'package:expense_tracker/view/login/login.screen.tablet.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'Login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(
      desktopScreen: LoginScreenDesktop(),
      tabletScreen: LoginScreenTablet(),
      mobileScreen: LoginScreenMobile(),
    );
  }
}


/*


IconButton(
    icon: showPassword
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off),
    onPressed: () {
      setState(() {
        showPassword = !showPassword;
      });
    },
  ),

*/