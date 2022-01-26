import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/route.provider.dart';
import 'package:expense_tracker/view/android/home/android.home.screen.dart';
import 'package:expense_tracker/view/android/login/android.login.screen.dart';
import 'package:expense_tracker/view/android/register/android.register.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AndroidSplashScreen extends StatefulWidget {
  const AndroidSplashScreen({Key? key}) : super(key: key);

  @override
  _AndroidSplashScreenState createState() => _AndroidSplashScreenState();
}

class _AndroidSplashScreenState extends State<AndroidSplashScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
        // do whatever you want based on the firebaseUser state

        if (firebaseUser != null) {
          if (mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => const AndroidHomeScreen()));
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
          ? const AndroidRegScreen()
          : screenName == kLoginScreen
              ? const AndroidLoginScreen()
              : Container(),
    );
  }
}
