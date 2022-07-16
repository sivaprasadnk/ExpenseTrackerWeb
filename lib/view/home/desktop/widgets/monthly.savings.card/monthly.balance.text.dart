import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyBalanceText extends StatelessWidget {
  const MonthlyBalanceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return Text(
          "${provider.monthlyDrOrCr} ${provider.currencySymbol} ${provider.monthlyBalance}",
          style: TextStyle(
            height: 0.8,
            fontSize: 53,
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
          ),
        );
      },
    );
  }
}
