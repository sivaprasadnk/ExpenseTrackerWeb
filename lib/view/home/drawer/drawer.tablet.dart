import 'package:expense_tracker/view/home/drawer/widgets/back.arrow.dart';
import 'package:expense_tracker/view/home/drawer/widgets/change.theme.dart';
import 'package:expense_tracker/view/home/drawer/widgets/go.home.menu.dart';
import 'package:expense_tracker/view/home/drawer/widgets/log.out.button.dart';
import 'package:expense_tracker/view/home/drawer/widgets/settings.text.container.dart';
import 'package:expense_tracker/view/home/drawer/widgets/version.text.dart';
import 'package:expense_tracker/view/home/drawer/widgets/visit.play.store.dart';
import 'package:expense_tracker/view/home/drawer/widgets/visit.web.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerTablet extends StatefulWidget {
  const DrawerTablet({Key? key}) : super(key: key);

  @override
  _DrawerTabletState createState() => _DrawerTabletState();
}

class _DrawerTabletState extends State<DrawerTablet> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const BackArrow(),
          const SizedBox(height: 10),
          const SettingsTextContainer(),
          const SizedBox(height: 10),
          GoHomeMenu(fontSize: 12.sp),
          const SizedBox(height: 20),
          ChangeThemeMenu(fontSize: 12.sp),
          const SizedBox(height: 20),
          VisitWeb(fontSize: 12.sp),
          const SizedBox(height: 20),
          VisitPlayStore(fontSize: 12.sp),
          const SizedBox(height: 20),
          const LogoutButton(),
          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          const SizedBox(height: 20),
          VersionText(fontSize: 12.sp),
        ],
      ),
    );
  }
}
