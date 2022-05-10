import 'package:expense_tracker/view/windows/small/home/windows.small.home.screen.dart';
import 'package:expense_tracker/view/windows/small/login/windows.small.login.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const WindowsSmallHome()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const WindowsSmallLoginScreen()));
      }
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (mounted) {
      //     if (user == null) {
      //       if (mounted) {
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (ctx) => const WindowsSmallLoginScreen()));
      //       }
      //     } else {
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (ctx) => const WindowsSmallHome()));
      //     }
      //   }
      // });
    });
    // if (mounted) {
    //   FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
    //     // do whatever you want based on the firebaseUser state
    //     if (mounted) {
    //       Future.delayed(const Duration(seconds: 1)).then((value) {
    //         if (firebaseUser != null) {
    //           if (mounted) {
    //             Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (ctx) => const WindowsSmallHome()));
    //           }
    //         }
    //       });
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // final screenWidth = screenSize.width;
    // var screenName = Provider.of<RouteProvider>(context).screen;
    // AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
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
