import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class WindowsSplashScreen extends StatefulWidget {
  const WindowsSplashScreen({Key? key}) : super(key: key);

  @override
  _WindowsSplashScreenState createState() => _WindowsSplashScreenState();
}

class _WindowsSplashScreenState extends State<WindowsSplashScreen> {
  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  asyncInitState() async {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        if ((defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const HomeScreenMobile()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const HomeScreenDesktop()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
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
