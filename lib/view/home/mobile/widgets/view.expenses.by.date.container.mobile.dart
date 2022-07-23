import 'package:expense_tracker/view/expense.date.list/expense.date.list.mobile.screen.dart';
import 'package:flutter/material.dart';

class ViewExpensesByDateContainerMobile extends StatelessWidget {
  const ViewExpensesByDateContainerMobile(
      {Key? key, required this.width, required this.height})
      : super(key: key);
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
          children: const [
            Text(
              ' View Expenses \n by Date',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   ' by Date',
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
