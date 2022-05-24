import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/expense.by.category/expense.by.category.mobile.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewExpenseByCategoryContainerMobile extends StatelessWidget {
  const ViewExpenseByCategoryContainerMobile({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const ExpenseByCategoryMobileScreen()),
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
                // fontFamily: 'Rajdhani',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' by Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // fontFamily: 'Rajdhani',
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
