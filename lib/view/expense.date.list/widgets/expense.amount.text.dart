import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseAmountText extends StatelessWidget {
  const ExpenseAmountText(
      {Key? key,
      required this.amount,
      required this.borderColor,
      required this.fillColor})
      : super(key: key);
  final String amount;
  final Color borderColor;
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    return Positioned.fill(
      right: -2,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "$kRupeeSymbol " + amount,
          ),
        ),
      ),
    );
  }
}
