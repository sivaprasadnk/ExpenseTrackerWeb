import 'package:expense_tracker/utils/navigation.dart';
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
    debugPrint('.. @@ 1');
    Future.delayed(const Duration(seconds: 1)).then((_) async {
        Navigation.checkPlatformAndNavigateToLogin(context: context);

      // if (FirebaseAuth.instance.currentUser != null) {
      //   debugPrint('.. @@ 2');

      //   String userId = FirebaseAuth.instance.currentUser!.uid;
      //   var width = MediaQuery.of(context).size.width;
      //   UserController.getExpenseDetailsAndNavigateToHome(
      //       context, userId, width);
      // } else {
      //   Navigation.checkPlatformAndNavigateToLogin(context: context);
      // }
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
