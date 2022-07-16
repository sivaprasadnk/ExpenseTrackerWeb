import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.total.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/expense.title.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/income.title.title.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/income.total.container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'online.total.container.dart';

class MonthlyBalanceContainer extends StatefulWidget {
  const MonthlyBalanceContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthlyBalanceContainer> createState() =>
      _MonthlyBalanceContainerState();
}

class _MonthlyBalanceContainerState extends State<MonthlyBalanceContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return Consumer<HomeProvider>(builder: (_, provider, __) {
      return Stack(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => const TodaysExpenseListDesktopScreen()));
            },
            onHover: (val) {
              setState(() {
                isHovered = val;
              });
            },
            child: Container(
              height: 150,
              width: 430,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(
                  width: isHovered ? 2 : 1,
                  color: !isHovered ? primaryColor : theme.cardColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Monthly Savings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
                  const MonthlyBalanceText(),
                ],
              ),
            ),
          ),
          IncomeTitleText(theme: theme),
          ExpenseTitleText(theme: theme),
          IncomeTotalContainer(
            theme: theme,
            amount: provider.monthlyTotalIncome.toString(),
          ),
          ExpenseTotalContainer(
            theme: theme,
            amount: provider.monthlyTotalExpense.toString(),
          )
        ],
      );
    });
  }
}
