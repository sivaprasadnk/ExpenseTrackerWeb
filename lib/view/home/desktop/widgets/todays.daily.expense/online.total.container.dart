import 'package:expense_tracker/view/expense.list.by.date/widgets/online.total.text.dart';
import 'package:flutter/material.dart';

class OnlineTotalContainer extends StatelessWidget {
  const OnlineTotalContainer({
    Key? key,
    required this.theme,
    required this.amount,
  }) : super(key: key);

  final ThemeData theme;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 20,
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
          child: OnlineTotalText(
            amount: amount,
          ),
        ),
      ),
    );
  }
}
