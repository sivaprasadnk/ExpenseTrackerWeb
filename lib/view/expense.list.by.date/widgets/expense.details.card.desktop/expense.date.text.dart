import 'package:flutter/material.dart';

class ExpenseDateText extends StatelessWidget {
  const ExpenseDateText({
    Key? key,
    required this.date,
    required this.month,
    this.fontSize = 15,
  }) : super(key: key);
  final String date;
  final String month;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      date + " " + month,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
