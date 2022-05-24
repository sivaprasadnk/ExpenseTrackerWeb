import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/daily.total.text.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.desktop.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
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
                color: !isHovered ? primaryColor : theme.themeData.cardColor,
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
                    // fontFamily: 'Rajdhani',
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
