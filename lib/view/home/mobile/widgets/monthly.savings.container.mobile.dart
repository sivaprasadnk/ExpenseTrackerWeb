import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/widgets/monthly.savings.container/monthly.balance.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/monthly.savings.container/view.statistics.button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../desktop/widgets/monthly.savings.container/add.transaction.button.dart';
import '../../desktop/widgets/monthly.savings.container/monthly.savings.title.text.dart';

class MonthlySavingsContainerMobile extends StatefulWidget {
  const MonthlySavingsContainerMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthlySavingsContainerMobile> createState() =>
      _MonthlySavingsContainerMobileState();
}

class _MonthlySavingsContainerMobileState
    extends State<MonthlySavingsContainerMobile> {
  bool isHovered = false;

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
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
                    const MonthlyBalanceText(),
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
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                      sections: showingSections(
                        60, 40,
                        // provider.monthlyTotalIncome,
                        // provider.monthlyTotalExpense,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
