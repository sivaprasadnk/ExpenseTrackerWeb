import 'package:expense_tracker/view/expense.date.list/mobile/expense.by.date.mobile.screen.dart';
import 'package:flutter/material.dart';

class ViewExpensesByDateContainerMobile extends StatelessWidget {
  const ViewExpensesByDateContainerMobile({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
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
        height: 150,
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
              'View Expenses',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' by Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
