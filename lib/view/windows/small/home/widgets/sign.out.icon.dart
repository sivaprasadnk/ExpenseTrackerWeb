import 'package:expense_tracker/view/windows/windows.splash.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOutIcon extends StatelessWidget {
  const SignOutIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // FirebaseFirestore.instance.collection(kUsersCollection)
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (ctx) => const WindowsSplashScreen()));
        });
        // FirebaseAuth.instance.signOut();
      },
      icon: Icon(Icons.logout,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black),
    );
  }
}
