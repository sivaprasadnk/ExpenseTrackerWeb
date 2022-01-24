import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/route.provider.dart';
import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:expense_tracker/view/register/register.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    var screenName = Provider.of<RouteProvider>(context).screen;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Provider.of<RouteProvider>(context, listen: false)
                  .setScreen(name: kLoginScreen);
              setState(() {});
            },
            child: SizedBox(
              width: screenWidth / 6,
              child: const Center(child: Text('Login')),
            ),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('.. @@');
              Provider.of<RouteProvider>(context, listen: false)
                  .setScreen(name: kRegisterScreen);
              setState(() {});
            },
            child: SizedBox(
              width: screenWidth / 6,
              child: const Center(child: Text('Register')),
            ),
          ),
        ],
      ),
      body: screenName == kRegisterScreen
          ? const RegisterScreen()
          : screenName == kLoginScreen
              ? const LoginScreen()
              : Container(),
    );
  }
}
