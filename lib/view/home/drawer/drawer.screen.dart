import 'package:expense_tracker/view/home/drawer/widgets/back.arrow.dart';
import 'package:expense_tracker/view/home/drawer/widgets/change.theme.dart';
import 'package:expense_tracker/view/home/drawer/widgets/log.out.button.dart';
import 'package:expense_tracker/view/home/drawer/widgets/settings.text.container.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 20),
        BackArrow(),
        SizedBox(height: 10),
        SettingsTextContainer(),
        SizedBox(height: 10),
        // DarkThemeCheckBox(),
        ChangeThemeMenu(),
        // ThemeList(),
        SizedBox(height: 20),

        LogoutButton()
      ],
    );
  }
}
