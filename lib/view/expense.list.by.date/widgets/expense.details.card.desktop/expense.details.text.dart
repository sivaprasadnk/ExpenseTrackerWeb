import 'package:flutter/material.dart';

class ExpenseDetailsText extends StatelessWidget {
  const ExpenseDetailsText({
    Key? key,
    required this.details,
    this.fontSize = 12,
  }) : super(key: key);
  final String details;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      details,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
