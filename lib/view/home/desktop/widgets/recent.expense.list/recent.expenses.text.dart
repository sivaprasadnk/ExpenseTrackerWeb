import 'package:flutter/material.dart';

class RecentExpensesText extends StatelessWidget {
  const RecentExpensesText({Key? key, this.leftPadding = 10}) : super(key: key);
  final double leftPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0) + EdgeInsets.only(left: leftPadding),
      child: const Text(
        'Recent Expenses',
        style: TextStyle(
          fontSize: 20,
          // fontFamily: 'Rajdhani',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
