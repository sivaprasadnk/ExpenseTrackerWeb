import 'package:expense_tracker/utils/responsive.screen.dart';
import 'package:expense_tracker/view/register/register.screen.desktop.dart';
import 'package:expense_tracker/view/register/register.screen.mobile.dart';
import 'package:flutter/material.dart';

import 'register.screen.tablet.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = 'Register';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(
      desktopScreen: RegisterScreenDesktop(),
      tabletScreen: RegisterScreenTablet(),
      mobileScreen: RegisterScreenMobile(),
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