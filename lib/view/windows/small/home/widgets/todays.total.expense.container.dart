import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/daily.total.text.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/transition.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodaysTotalExpenseContainer extends StatelessWidget {
  const TodaysTotalExpenseContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return Stack(
      children: [
        TransitionWidget(
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Todays Total Expense :',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Rajdhani',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DailyTotalText(),
              ],
            ),
          ),
        ),
        Positioned.fill(
          // bottom: 10,
          right: 10,
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ),
        )
      ],
    );
  }
}
