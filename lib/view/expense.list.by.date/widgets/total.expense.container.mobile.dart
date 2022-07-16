import 'package:expense_tracker/view/expense.list.by.date/widgets/total.expense.title.text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/home.provider.dart';

class TotalExpenseContainerMobile extends StatelessWidget {
  const TotalExpenseContainerMobile({
    Key? key,
    required this.totalExpense,
    required this.title,
    required this.cashTotal,
    required this.onlineTotal,
  }) : super(key: key);
  final int totalExpense;
  final String cashTotal;
  final String onlineTotal;
  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return Stack(
      children: [
        Container(
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
        ),
        TotalExpenseTitleText(title: title),
        //         CashTitleText(theme: theme),
        // OnlineTitleText(theme: theme),
        // CashTotalContainer(theme: theme, amount: cashTotal,),
        // OnlineTotalContainer(theme: theme, amount: onlineTotal,)

      ],
    );
  }
}
