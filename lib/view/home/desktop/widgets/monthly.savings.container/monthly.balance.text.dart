import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalBalanceText extends StatelessWidget {
  const TotalBalanceText({
    Key? key,
    required this.balance,
    required this.drOrCr,
  }) : super(key: key);

  final int balance;
  final String drOrCr;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        "$drOrCr $currency $balance",
        style: TextStyle(
          height: 0.8,
          fontSize: 53,
          fontWeight: FontWeight.bold,
          color: theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
