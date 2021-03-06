import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/home.provider.dart';

class ExpenseAmountTextOld extends StatelessWidget {
  const ExpenseAmountTextOld(
      {Key? key,
      required this.amount,
      required this.borderColor,
      required this.fillColor})
      : super(key: key);
  final String amount;
  final Color borderColor;
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return Positioned.fill(
          right: -2,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "${provider.currencySymbol} " + amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
