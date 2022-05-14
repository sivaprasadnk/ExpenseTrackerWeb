import 'package:expense_tracker/common_strings.dart';
import 'package:flutter/material.dart';

class ExpenseAmountText extends StatelessWidget {
  const ExpenseAmountText({Key? key, required this.amount}) : super(key: key);
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Text(
      kRupeeSymbol + amount,
      style: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        fontFamily: 'Rajdhani',
      ),
    );
  }
}
