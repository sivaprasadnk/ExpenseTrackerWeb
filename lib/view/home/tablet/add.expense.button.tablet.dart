import 'package:expense_tracker/view/add_expense/add.expense.mobile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddExpenseButtonTablet extends StatelessWidget {
  const AddExpenseButtonTablet({Key? key, required this.height})
      : super(key: key);

  final double height;
  // final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var primaryColor = theme.primaryColor;

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AddExpenseMobile.routeName);
      },
      child: Container(
        height: height,
        width: screenWidth / 3 - 5.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "Add \n Expense",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
