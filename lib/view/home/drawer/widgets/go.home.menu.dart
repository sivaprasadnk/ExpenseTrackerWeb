import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GoHomeMenu extends StatelessWidget {
  const GoHomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () {
            double width = MediaQuery.of(context).size.width;
        if (width<480) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreenMobile.routeName, (r) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreenDesktop.routeName, (r) => false);
        }
      },
      icon: Icons.home,
      title: 'Go Home',
    );
  }
}
