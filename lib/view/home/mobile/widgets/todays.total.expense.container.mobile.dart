import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.title.title.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.total.container.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.total.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/online.title.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/online.total.container.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.mobile.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodaysTotalExpenseContainerMobile extends StatelessWidget {
  const TodaysTotalExpenseContainerMobile({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return Consumer<HomeProvider>(builder: (_, provider, __) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, TodaysExpenseListMobileScreen.routeName);
            },
            child: Container(
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
                    'Todays Total Expense :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: bgColor,
                    ),
                  ),
                  const DailyTotalText(),
                ],
              ),
            ),
          ),
          CashTitleText(theme: theme),
          OnlineTitleText(theme: theme),
          CashTotalContainer(
            theme: theme,
            amount: provider.dailyCashTotal.toString(),
          ),
          OnlineTotalContainer(
            theme: theme,
            amount: provider.dailyOnlineTotal.toString(),
          )
        ],
      );
    });
  }
}
