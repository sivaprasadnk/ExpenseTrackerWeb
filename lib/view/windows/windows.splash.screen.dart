import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/route.provider.dart';
import 'package:expense_tracker/view/windows/small/home/windows.small.home.screen.dart';
import 'package:expense_tracker/view/windows/small/login/windows.small.login.screen.dart';
import 'package:expense_tracker/view/windows/small/register/windows.small.register.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WindowsSplashScreen extends StatefulWidget {
  const WindowsSplashScreen({Key? key}) : super(key: key);

  @override
  _WindowsSplashScreenState createState() => _WindowsSplashScreenState();
}

class _WindowsSplashScreenState extends State<WindowsSplashScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
        // do whatever you want based on the firebaseUser state

        if (firebaseUser != null) {
          if (mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => const WindowsSmallHome()));
          }
        }
      });
    }
  }

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
          ? const WindowsSmallRegScreen()
          : screenName == kLoginScreen
              ? const WindowsSmallLoginScreen()
              : Container(),
    );
  }
}
