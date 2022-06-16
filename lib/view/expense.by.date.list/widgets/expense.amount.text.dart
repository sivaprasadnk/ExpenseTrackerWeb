import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseAmountText extends StatelessWidget {
  const ExpenseAmountText({Key? key, required this.amount}) : super(key: key);
  final String amount;
  @override
  Widget build(BuildContext context) {
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return Positioned.fill(
      right: 10,
      bottom: -10,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          "$currency $amount",
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
