import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.total.text.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.mobile.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodaysTotalExpenseContainerMobile extends StatelessWidget {
  const TodaysTotalExpenseContainerMobile({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
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
                    color: theme.themeData.scaffoldBackgroundColor,
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
              color: theme.themeData.scaffoldBackgroundColor,
            ),
          ),
        )
      ],
    );
  }
}
