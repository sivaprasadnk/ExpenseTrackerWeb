import 'package:expense_tracker/utils/responsive.screen.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.desktop.screen.dart';
import 'package:flutter/material.dart';

import 'todays.expense.list.mobile.screen.dart';

class TodaysExpenseListScreen extends StatefulWidget {
  const TodaysExpenseListScreen({Key? key}) : super(key: key);
  static const routeName = 'TodaysExpenseList';
  @override
  _TodaysExpenseListScreenState createState() =>
      _TodaysExpenseListScreenState();
}

class _TodaysExpenseListScreenState extends State<TodaysExpenseListScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(
      desktopScreen: TodaysExpenseListDesktopScreen(),
      tabletScreen: TodaysExpenseListMobileScreen(),
      mobileScreen: TodaysExpenseListMobileScreen(),
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