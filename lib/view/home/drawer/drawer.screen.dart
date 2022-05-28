import 'package:expense_tracker/view/home/drawer/widgets/back.arrow.dart';
import 'package:expense_tracker/view/home/drawer/widgets/change.theme.dart';
import 'package:expense_tracker/view/home/drawer/widgets/go.home.menu.dart';
import 'package:expense_tracker/view/home/drawer/widgets/log.out.button.dart';
import 'package:expense_tracker/view/home/drawer/widgets/settings.text.container.dart';
import 'package:expense_tracker/view/home/drawer/widgets/version.text.dart';
import 'package:expense_tracker/view/home/drawer/widgets/visit.play.store.dart';
import 'package:expense_tracker/view/home/drawer/widgets/visit.web.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          SizedBox(height: 20),
          BackArrow(),
          SizedBox(height: 10),
          SettingsTextContainer(),
          SizedBox(height: 10),
          GoHomeMenu(),
          SizedBox(height: 20),

          ChangeThemeMenu(),
          // ThemeList(),
          SizedBox(height: 20),

          // AppName(),
          VisitWeb(),
          SizedBox(height: 20),
          VisitPlayStore(),
          SizedBox(
            height: 20,
          ),
          LogoutButton(),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          SizedBox(height: 20),

          VersionText(),
        ],
      ),
    );
  }
}
