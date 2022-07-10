import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnlineTotalText extends StatelessWidget {
  const OnlineTotalText({
    Key? key,
    required this.amount,
    this.fontSize = 25,
    this.padding = 10,
  }) : super(key: key);
  final String amount;
  final double fontSize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Consumer<HomeProvider>(
        builder: (_, provider, __) {
          return Text(
            "${provider.currencySymbol} $amount",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: theme.scaffoldBackgroundColor,
            ),
          );
        },
      ),
    );
  }
}
