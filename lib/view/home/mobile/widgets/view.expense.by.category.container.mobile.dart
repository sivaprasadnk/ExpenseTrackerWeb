import 'package:expense_tracker/view/expense.category.list/expense.category.list.mobile.screen.dart';
import 'package:flutter/material.dart';

class ViewExpenseByCategoryContainerMobile extends StatelessWidget {
  const ViewExpenseByCategoryContainerMobile({
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
          children: const [
            Text(
              'View Expenses \n by Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   ' by Category',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 15,
            //     color: Colors.red,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
