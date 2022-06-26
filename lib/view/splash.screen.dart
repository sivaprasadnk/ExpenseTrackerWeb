import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/utils/navigation.dart';
import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:expense_tracker/view/login/login.screen.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  asyncInitState() async {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      if (FirebaseAuth.instance.currentUser != null) {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        UserController.getExpenseDetails(context, userId);
      } else {
        Navigation.checkPlatformAndNavigateToLogin(context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/mesh1.jpg'),
          ),
        ),
        child: const Center(
          child: NeumorphicLoader(
            size: 70,
            borderColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
