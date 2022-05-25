import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:flutter/material.dart';

class VersionText extends StatelessWidget {
  const VersionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
        onTap: () {}, icon: Icons.info, title: 'Version :    1.0.0');
  }
}
