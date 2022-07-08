import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.title.title.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.total.container.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.total.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/online.title.text.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.desktop.screen.dart';
import 'package:flutter/material.dart';

import 'online.total.container.dart';

class TodaysTotalExpenseContainer extends StatefulWidget {
  const TodaysTotalExpenseContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<TodaysTotalExpenseContainer> createState() =>
      _TodaysTotalExpenseContainerState();
}

class _TodaysTotalExpenseContainerState
    extends State<TodaysTotalExpenseContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const TodaysExpenseListDesktopScreen()));
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
                  'Todays Total Expense',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
                const DailyTotalText(),
              ],
            ),
          ),
        ),
        CashTitleText(theme: theme),
        OnlineTitleText(theme: theme),
        CashTotalContainer(theme: theme),
        OnlineTotalContainer(theme: theme)
      ],
    );
  }
}
