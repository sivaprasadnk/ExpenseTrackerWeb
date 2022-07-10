import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/responsive.screen.dart';
import 'package:expense_tracker/view/edit.expense/edit.expense.desktop.dart';
import 'package:expense_tracker/view/edit.expense/edit.expense.mobile.dart';
import 'package:expense_tracker/view/edit.expense/edit.expense.tablet.dart';
import 'package:flutter/material.dart';

class EditExpenseScreen extends StatelessWidget {
  const EditExpenseScreen({Key? key, required this.expense}) : super(key: key);
  static const routeName = 'EditExpense';
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      desktopScreen: EditExpenseScreenDesktop(
        expense: expense,
      ),
      tabletScreen: EditExpenseScreenTablet(
        expense: expense,
      ),
      mobileScreen: EditExpenseScreenMobile(
        expense: expense,
      ),
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