import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/windows.splash.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () {
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (ctx) => const WindowsSplashScreen()));
        });
      },
      icon: Icons.logout,
      title: 'Logout',
    );
    // return Row(
    //   children: [
    //     const SizedBox(
    //       width: 20,
    //     ),
    //     IconButton(
    //       onPressed: () {
    //         FirebaseAuth.instance.signOut().then((value) {
    //           Navigator.pushReplacement(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (ctx) => const WindowsSplashScreen()));
    //         });
    //       },
    //       icon: Icon(
    //         Icons.logout,
    //         color: Theme.of(context).brightness == Brightness.dark
    //             ? Colors.white
    //             : Colors.black,
    //       ),
    //     ),
    //     const SizedBox(
    //       width: 20,
    //     ),
    //     const Text(
    //       'Logout',
    //       style: TextStyle(
    //         fontSize: 20,
    //       ),
    //     ),
    //   ],
    // );
  }
}
