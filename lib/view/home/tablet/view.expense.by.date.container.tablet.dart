import 'package:expense_tracker/view/expense.date.list/expense.date.list.mobile.screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewExpensesByDateContainerTablet extends StatelessWidget {
  const ViewExpensesByDateContainerTablet(
      {Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ExpenseByDateMobileScreen()),
        );
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "View Expenses",
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'by Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
                // color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
