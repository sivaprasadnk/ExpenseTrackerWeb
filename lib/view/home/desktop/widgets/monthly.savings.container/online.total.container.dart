import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.total.text.dart';
import 'package:flutter/material.dart';

class ExpenseTotalContainer extends StatelessWidget {
  const ExpenseTotalContainer({
    Key? key,
    required this.theme,
    required this.amount,
    this.fontSize = 25,
    this.padding = 10,
    this.bottonPadding = 20,
  }) : super(key: key);

  final ThemeData theme;
  final String amount;
  final double fontSize;
  final double padding;
  final double bottonPadding;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: bottonPadding,
      right: -1,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.scaffoldBackgroundColor,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: ExpenseTotalText(
            amount: amount,
            fontSize: fontSize,
            padding: padding,
          ),
        ),
      ),
    );
  }
}
