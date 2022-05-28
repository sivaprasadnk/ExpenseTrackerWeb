import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/select.theme/select.theme.desktop.screen.dart';
import 'package:expense_tracker/view/select.theme/select.theme.mobile.screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChangeThemeMenu extends StatefulWidget {
  const ChangeThemeMenu({Key? key}) : super(key: key);

  @override
  State<ChangeThemeMenu> createState() => _ChangeThemeMenuState();
}

class _ChangeThemeMenuState extends State<ChangeThemeMenu> {
  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () {
        Navigator.pop(context);
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS) {
          Navigator.pushNamed(context, SelectThemeMobileScreen.routeName);
        } else {
          Navigator.pushNamed(context, SelectThemeDesktopScreen.routeName);
        }
      },
      title: 'Change Theme',
      icon: Icons.format_paint_outlined,
    );
  }
}
