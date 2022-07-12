import 'package:flutter/material.dart';

class TodaysTransactionsTitleText extends StatelessWidget {
  const TodaysTransactionsTitleText({
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
        'Todays Transactions',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
