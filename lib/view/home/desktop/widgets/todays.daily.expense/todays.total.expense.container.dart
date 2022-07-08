import 'package:expense_tracker/utils/translate.extension.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.cash.total.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.total.text.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.desktop.screen.dart';
import 'package:flutter/material.dart';

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
        Positioned.fill(
          right: 10,
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ),
        Positioned.fill(
          bottom: 65,
          left: 10,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Cash :',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
        const Positioned.fill(
          bottom: 20,
          left: 10,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: DailyCashTotalText(),
          ),
        )
      ],
    ).translateOnHover;
  }
}
