import 'package:expense_tracker/provider/home.provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'monthly.balance.text.dart';

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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 8, bottom: 13),
                      child: Text(
                        'Monthly Savings',
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: MonthlyBalanceText(),
                    ),
                    const Spacer(),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Text(
                                  'Statistics',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 13,
                                  color: theme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 75,
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.add,
                                  size: 13,
                                  color: theme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
            Positioned.fill(
              // top: 50,
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
            // IncomeTitleText(color: theme.scaffoldBackgroundColor),
            // ExpenseTitleText(theme: theme),
            // IncomeTotalContainer(
            //   theme: theme,
            //   amount: provider.monthlyTotalIncome.toString(),
            // ),
            // ExpenseTotalContainer(
            //   theme: theme,
            //   amount: provider.monthlyTotalExpense.toString(),
            // )
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
