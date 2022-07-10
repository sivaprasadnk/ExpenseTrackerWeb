import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.title.title.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/cash.total.container.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/online.title.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/todays.daily.expense/online.total.container.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TodaysTotalExpenseContainerTablet extends StatelessWidget {
  const TodaysTotalExpenseContainerTablet({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

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
              Navigator.pushNamed(context, TodaysExpenseListScreen.routeName);
            },
            child: Container(
              height: height,
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: bgColor,
                    ),
                  ),
                  Consumer<HomeProvider>(
                    builder: (_, provider, __) {
                      return Text(
                        "${provider.currencySymbol} ${provider.dailyTotalExpense}",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          CashTitleText(
            theme: theme,
            fontSize: 12.sp,
            bottomPadding: 7.h,
          ),
          OnlineTitleText(
            theme: theme,
            fontSize: 12.sp,
            bottomPadding: 7.h,
          ),
          CashTotalContainer(
            theme: theme,
            fontSize: 12.sp,
            padding: 3.w,
            bottonPadding: 3.h,
            amount: provider.dailyCashTotal.toString(),
          ),
          OnlineTotalContainer(
            theme: theme,
            fontSize: 12.sp,
            padding: 3.w,
            bottonPadding: 3.h,
            amount: provider.dailyOnlineTotal.toString(),
          )
        ],
      );
    });
  }
}
