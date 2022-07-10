import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/home/home.screen.dart';
import 'package:flutter/material.dart';

class GoHomeMenu extends StatelessWidget {
  const GoHomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () {
        // double width = MediaQuery.of(context).size.width;
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (r) => false);

        // if (width<480) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, HomeScreen.routeName, (r) => false);
        // } else {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, HomeScreenDesktop.routeName, (r) => false);
        // }
      },
      icon: Icons.home,
      title: 'Go Home',
    );
  }
}
