import 'package:expense_tracker/common_strings.dart';
import 'package:flutter/material.dart';

class ExpenseAmountText extends StatelessWidget {
  const ExpenseAmountText({Key? key, required this.amount}) : super(key: key);
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      right: 10,
      bottom: -10,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          "$kRupeeSymbol $amount",
          style: const TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ),
    );
  }
}
