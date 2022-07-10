import 'package:expense_tracker/utils/responsive.screen.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/home.screen.tablet.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'Home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(
      desktopScreen: HomeScreenDesktop(),
      tabletScreen: HomeScreenTablet(),
      mobileScreen: HomeScreenMobile(),
    );
  }
}


/*


IconButton(
    icon: showPassword
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off),
    onPressed: () {
      setState(() {
        showPassword = !showPassword;
      });
    },
  ),

*/