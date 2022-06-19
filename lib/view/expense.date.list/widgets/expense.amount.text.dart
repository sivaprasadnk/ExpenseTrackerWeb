import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/home.provider.dart';

class ExpenseAmountText extends StatelessWidget {
  const ExpenseAmountText({
    Key? key,
    required this.amount,
    required this.textColor,
    this.fontSize=15,
  }) : super(key: key);

  final String amount;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return Text(
      '$currency $amount',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: textColor,
        height: 0.7,
      ),
    );
  }
}
