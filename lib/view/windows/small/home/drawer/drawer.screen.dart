import 'package:expense_tracker/view/windows/small/home/drawer/widgets/back.arrow.dart';
import 'package:expense_tracker/view/windows/small/home/drawer/widgets/settings.text.container.dart';
import 'package:expense_tracker/view/windows/small/home/drawer/widgets/theme.list.dart';
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
      children: [
        SizedBox(height: 20),
        BackArrow(),
        SizedBox(height: 10),
        SettingsTextContainer(),
        SizedBox(height: 10),
        // DarkThemeCheckBox(),
        ThemeList(),
      ],
    );
  }
}
