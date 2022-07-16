import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodaysTransactionsTitleText extends StatelessWidget {
  const TodaysTransactionsTitleText({
    Key? key,
    this.leftPadding = 10,
    this.fontSize = 20,
  }) : super(key: key);
  final double leftPadding;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0) + EdgeInsets.only(left: leftPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Todays Transactions',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer<HomeProvider>(builder: (_, provider, __) {
            return Text(
              '${provider.dailyDrOrCr} ${provider.currencySymbol}  ${provider.dailyBalance}',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ],
      ),
    );
  }
}
