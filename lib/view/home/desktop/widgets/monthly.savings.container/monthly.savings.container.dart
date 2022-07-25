import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/model/get.balances.response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'add.transaction.button.dart';
import 'monthly.balance.text.dart';
import 'monthly.savings.title.text.dart';
import 'view.statistics.button.dart';

class MonthlySavingsContainerDesktop extends StatefulWidget {
  const MonthlySavingsContainerDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthlySavingsContainerDesktop> createState() =>
      _MonthlySavingsContainerDesktopState();
}

class _MonthlySavingsContainerDesktopState
    extends State<MonthlySavingsContainerDesktop> {
  GetBalancesResponse? response;

  bool isHovered = false;

  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    response = await UserRepo().getCurrentBalancesV2();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return Stack(
      children: [
        Container(
          height: 200,
          width: 430,
          decoration: BoxDecoration(
            color: primaryColor,
            border: Border.all(
              width: isHovered ? 2 : 1,
              color: !isHovered ? primaryColor : theme.cardColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MonthlySavingsTitleText(),
                MonthlyBalanceText(
                  drOrCr: response!.drOrCr,
                  balance: response!.totalBalance,
                ),
                const Spacer(),
                Row(
                  children: const [
                    SizedBox(width: 8),
                    ViewStatisticsButton(),
                    SizedBox(width: 20),
                    AddTransactionButton()
                  ],
                ),
                const SizedBox(height: 5)
              ],
            ),
          ),
        ),
        Positioned.fill(
          right: 35,
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 105,
              width: 105,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 30,
                  sections: showingSections(
                    response!.totalIncome,
                    response!.totalExpense,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(int income, int expense) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 15.0 : 13.0;
      final radius = isTouched ? 50.0 : 40.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: double.parse(income.toString()),
            title: 'Income',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(
              expense.toString(),
            ),
            title: 'Expense',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
