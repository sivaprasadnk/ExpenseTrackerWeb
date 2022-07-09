import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashTotalText extends StatelessWidget {
  const CashTotalText({Key? key, required this.amount}) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Consumer<HomeProvider>(
        builder: (_, provider, __) {
          return Text(
            "${provider.currencySymbol} $amount",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: theme.scaffoldBackgroundColor,
            ),
          );
        },
      ),
    );
  }
}
