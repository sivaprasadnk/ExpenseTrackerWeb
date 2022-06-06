import 'package:flutter/material.dart';

class ExpenseDateText extends StatelessWidget {
  const ExpenseDateText({Key? key, required this.date, required this.month})
      : super(key: key);
  final String date;
  final String month;
  @override
  Widget build(BuildContext context) {
    return Text(
      date + " " + month,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
