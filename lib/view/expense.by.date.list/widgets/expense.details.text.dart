import 'package:flutter/material.dart';

class ExpenseDetailsText extends StatelessWidget {
  const ExpenseDetailsText({Key? key, required this.details}) : super(key: key);
  final String details;
  @override
  Widget build(BuildContext context) {
    return Text(
      details,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
