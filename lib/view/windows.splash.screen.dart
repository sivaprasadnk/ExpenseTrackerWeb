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
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   // appBar: AppBar(
    //   //   elevation: 0,
    //   //   backgroundColor: Colors.transparent,
    //   //   actions: [
    //   //     GestureDetector(
    //   //       onTap: () {
    //   //         Provider.of<RouteProvider>(context, listen: false)
    //   //             .setScreen(name: kLoginScreen);
    //   //         setState(() {});
    //   //       },
    //   //       child: SizedBox(
    //   //         width: screenWidth / 6,
    //   //         child: const Center(child: Text('Login')),
    //   //       ),
    //   //     ),
    //   //     GestureDetector(
    //   //       onTap: () {
    //   //         debugPrint('.. @@');
    //   //         Provider.of<RouteProvider>(context, listen: false)
    //   //             .setScreen(name: kRegisterScreen);
    //   //         setState(() {});
    //   //       },
    //   //       child: SizedBox(
    //   //         width: screenWidth / 6,
    //   //         child: const Center(child: Text('Register')),
    //   //       ),
    //   //     ),
    //   //   ],
    //   // ),
    //   body: StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (_, AsyncSnapshot<User?> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else {
    //         if (snapshot.hasError) {
    //           return Center(
    //             child: Icon(Icons.error),
    //           );
    //         }
    //         if (snapshot.hasData) {
    //           return WindowsSmallHome();
    //         } else {
    //           return WindowsSmallLoginScreen();
    //         }
    //       }
    //     },
    //   ),
    //   // body: screenName == kRegisterScreen
    //   //     ? const WindowsSmallRegScreen()
    //   //     : screenName == kLoginScreen
    //   //         ? const WindowsSmallLoginScreen()
    //   //         : Container(),
    // );
  }
}
