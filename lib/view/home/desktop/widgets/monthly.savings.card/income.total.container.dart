import 'package:expense_tracker/view/expense.list.by.date/widgets/Income.total.text.dart';
import 'package:flutter/material.dart';

class IncomeTotalContainer extends StatelessWidget {
  const IncomeTotalContainer({
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
              bottomRight: Radius.circular(6),
            ),
          ),
          child: IncomeTotalText(
            amount: amount,
            fontSize: fontSize,
            padding: padding,
          ),
        ),
      ),
    );
  }
}
