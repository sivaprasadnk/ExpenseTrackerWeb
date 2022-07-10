import 'package:flutter/material.dart';

class RecentExpensesText extends StatelessWidget {
  const RecentExpensesText({
    Key? key,
    this.leftPadding = 10,
    this.fontSize = 20,
  }) : super(key: key);
  final double leftPadding;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0) + EdgeInsets.only(left: leftPadding),
      child: Text(
        'Recent Expenses',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
