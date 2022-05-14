import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/windows/small/expense.by.category/expense.by.category.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewExpenseByCategoryContainer extends StatelessWidget {
  const ViewExpenseByCategoryContainer({Key? key, required this.maxWidth})
      : super(key: key);
  final double maxWidth;
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ExpenseByCategoryScreen()),
        );
      },
      child: Container(
        height: 150,
        width: maxWidth * 0.27,
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
                fontFamily: 'Rajdhani',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' by Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Rajdhani',
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
