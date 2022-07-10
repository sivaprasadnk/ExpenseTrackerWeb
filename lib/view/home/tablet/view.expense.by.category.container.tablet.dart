import 'package:expense_tracker/view/expense.category.list/expense.category.list.mobile.screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewExpenseByCategoryContainerTablet extends StatelessWidget {
  const ViewExpenseByCategoryContainerTablet({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var primaryColor = theme.primaryColor;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const ExpenseCategoryListMobileScreen()),
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
              'View Expenses',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'by Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                // color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
