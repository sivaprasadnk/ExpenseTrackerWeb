import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyTotalText extends StatelessWidget {
  const DailyTotalText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return Text(
          "${provider.currencySymbol} ${provider.dailyTotalExpense}",
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
          ),
        );
      },
    );
  }
}
