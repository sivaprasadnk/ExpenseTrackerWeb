import 'package:expense_tracker/view/expense.list.by.date/widgets/total.expense.title.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.title.title.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.total.container.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/online.title.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/online.total.container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/home.provider.dart';

class TotalExpenseContainerDesktop extends StatelessWidget {
  const TotalExpenseContainerDesktop({
    Key? key,
    required this.totalExpense,
    required this.title,
  }) : super(key: key);

  final int totalExpense;

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
          width: 430,
          margin: const EdgeInsets.only(left: 1),
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
                'Total Expense ',
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
        CashTitleText(theme: theme),
        OnlineTitleText(theme: theme),
        CashTotalContainer(theme: theme),
        OnlineTotalContainer(theme: theme)
      ],
    );
  }
}
