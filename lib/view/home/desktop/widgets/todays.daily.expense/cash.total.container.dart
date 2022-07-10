import 'package:expense_tracker/view/expense.list.by.date/widgets/cash.total.text.dart';
import 'package:flutter/material.dart';

class CashTotalContainer extends StatelessWidget {
  const CashTotalContainer({
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
      left: -1,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.scaffoldBackgroundColor,
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: CashTotalText(
            amount: amount,
            fontSize: fontSize,
            padding: padding,
          ),
        ),
      ),
    );
  }
}
