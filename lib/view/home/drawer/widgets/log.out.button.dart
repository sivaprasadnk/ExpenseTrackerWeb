import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/utils/custom.dialog.dart';
import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/splash.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () {
        Navigator.pop(context);
        double width = (defaultTargetPlatform == TargetPlatform.android ||
                defaultTargetPlatform == TargetPlatform.iOS)
            ? double.infinity
            : 360;
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) {
            return CustomDialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 150,
                    width: width,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Do you wish to Logout ?',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Rajdhani',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CursorWidget(
                              onTap: () {
                                Navigator.pop(ctx);
                              },
                              isButton: true,
                              borderColor: Theme.of(context).primaryColor,
                              bgColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              buttonWidth: 100,
                              child: const Center(
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            CursorWidget(
                              onTap: () {
                                Navigator.pop(ctx);
                                FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.pushReplacement(
                                    ctx,
                                    MaterialPageRoute(
                                      builder: (ctx) => const SplashScreen(),
                                    ),
                                  );
                                });
                              },
                              isButton: true,
                              borderColor: Theme.of(context).primaryColor,
                              bgColor: Theme.of(context).primaryColor,
                              buttonWidth: 100,
                              child: Center(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: Icons.logout,
      title: 'Logout',
    );
  }
}
