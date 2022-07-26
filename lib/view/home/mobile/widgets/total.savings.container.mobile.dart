import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/model/get.balances.response.dart';
import 'package:expense_tracker/view/home/desktop/widgets/monthly.savings.container/monthly.balance.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/monthly.savings.container/view.statistics.button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../desktop/widgets/monthly.savings.container/add.transaction.button.dart';
import '../../desktop/widgets/monthly.savings.container/total.savings.title.text.dart';

class TotalSavingsContainerMobile extends StatefulWidget {
  const TotalSavingsContainerMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalSavingsContainerMobile> createState() =>
      _TotalSavingsContainerMobileState();
}

class _TotalSavingsContainerMobileState
    extends State<TotalSavingsContainerMobile> {
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
    debugPrint('.. @@@@@');
    return Stack(
      children: [
        Container(
          height: 225,
          width: 500,
          // margin: const EdgeInsets.only(right: 20, left: 20),
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
                const TotalSavingsTitleText(),
                if (response != null)
                  TotalBalanceText(
                    drOrCr: response!.drOrCr,
                    balance: response!.totalBalance,
                  )
                else
                  const TotalBalanceText(
                    drOrCr: '+',
                    balance: 0,
                  ),
                const SizedBox(height: 10),
                const Spacer(),
                const SizedBox(height: 5)
              ],
            ),
          ),
        ),
        Positioned.fill(
          right: 50,
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 105,
              width: 105,
              child: PieChart(
                PieChartData(
                  // pieTouchData: PieTouchData(
                  //   touchCallback:
                  //     (FlTouchEvent event, pieTouchResponse) {
                  //     // setState(() {
                  //     //   if (!event.isInterestedForInteractions ||
                  //     //       pieTouchResponse == null ||
                  //     //       pieTouchResponse.touchedSection == null) {
                  //     //     touchedIndex = -1;
                  //     //     return;
                  //     //   }
                  //     //   touchedIndex = pieTouchResponse
                  //     //       .touchedSection!.touchedSectionIndex;
                  //     // });
                  //   },
                  // ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: response != null && response!.totalBalance != 0
                      ? showingSections(
                          response!.totalIncome,
                          response!.totalExpense,
                        )
                      : showingSections(50, 50),
                ),
              ),
            ),
          ),
        ),
        const ViewStatisticsButton(),
        const AddTransactionButton()
      ],
    );
  }

  List<PieChartSectionData> showingSections(int income, int expense) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 15.0 : 13.0;
      final radius = isTouched ? 60.0 : 40.0;
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
