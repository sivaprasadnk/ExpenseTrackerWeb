import 'package:flutter/material.dart';

import '../../../common_strings.dart';

class TotalExpenseContainerDesktop extends StatelessWidget {
  const TotalExpenseContainerDesktop({
    Key? key,
    required this.totalExpense,
  }) : super(key: key);

  final int totalExpense;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return Container(
      height: 150,
      width: 430,
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(
          width: 1,
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Total Expense :',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: bgColor,
            ),
          ),
          Text(
            "$kRupeeSymbol $totalExpense",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: bgColor,
            ),
          )
        ],
      ),
    );
  }
}
