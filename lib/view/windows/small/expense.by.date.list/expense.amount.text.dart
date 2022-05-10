import 'package:flutter/material.dart';

class ExpenseAmountText extends StatelessWidget {
  const ExpenseAmountText({Key? key, required this.amount}) : super(key: key);
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Text(
      amount,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: 'Rajdhani',
      ),
    );
  }
}
