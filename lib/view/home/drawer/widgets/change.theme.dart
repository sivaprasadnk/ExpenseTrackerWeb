import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/select.theme/select.theme.desktop.screen.dart';
import 'package:expense_tracker/view/select.theme/select.theme.mobile.screen.dart';
import 'package:flutter/material.dart';

class ChangeThemeMenu extends StatelessWidget {
  const ChangeThemeMenu({
    Key? key,
    this.fontSize = 20,
  }) : super(key: key);

  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () {
        Navigator.pop(context);
        double width = MediaQuery.of(context).size.width;

        if (width < 480) {
          Navigator.pushNamed(context, SelectThemeMobileScreen.routeName);
        } else {
          Navigator.pushNamed(context, SelectThemeDesktopScreen.routeName);
        }
      },
      title: 'Change Theme',
      icon: Icons.format_paint_outlined,
      fontSize: fontSize,
    );
  }
}
