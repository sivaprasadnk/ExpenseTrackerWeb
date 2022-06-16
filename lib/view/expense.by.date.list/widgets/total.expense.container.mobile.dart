import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_strings.dart';
import '../../../provider/home.provider.dart';

class TotalExpenseContainerMobile extends StatelessWidget {
  const TotalExpenseContainerMobile({
    Key? key,
    required this.totalExpense,
  }) : super(key: key);

  final int totalExpense;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return Container(
      height: 150,
      width: double.infinity,
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
            "$currency $totalExpense",
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
