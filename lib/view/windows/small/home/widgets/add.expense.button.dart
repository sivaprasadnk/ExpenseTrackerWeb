import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/windows/small/add_expense/add.expense.mobile.dart';
import 'package:expense_tracker/view/windows/small/add_expense/add.expense.windows.small.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;

    final screenSize = MediaQuery.of(context).size;
    // final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () {
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS) {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const AddExpenseMobile()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => const WindowsSmallAddExpenseScreen()));
        }
      },
      child: Container(
        height: 150,
        width: screenWidth * 0.27,
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Add ',
            style: TextStyle(
              fontFamily: 'Rajdhani',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
