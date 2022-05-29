import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/splash.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      removeContext: false,
      onTap: () {
        Dialogs.showConfirmDialog(
            context: context,
            title: 'Do you wish to logout ?',
            positiveCallBack: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()));
              });
            });
      },
      icon: Icons.logout,
      title: 'Logout',
    );
  }
}
