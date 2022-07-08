import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.cash.total.text.dart';
import 'package:flutter/material.dart';



class CashTotalContainer extends StatelessWidget {
  const CashTotalContainer({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 20,
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
          child: const DailyCashTotalText(),
        ),
      ),
    );
  }
}
