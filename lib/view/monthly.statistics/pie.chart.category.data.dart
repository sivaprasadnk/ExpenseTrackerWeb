import 'package:expense_tracker/provider/statistics.provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartCategoryData extends StatefulWidget {
  const PieChartCategoryData({Key? key}) : super(key: key);

  @override
  State<PieChartCategoryData> createState() => _PieChartCategoryDataState();
}

class _PieChartCategoryDataState extends State<PieChartCategoryData> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var bgColor = theme.scaffoldBackgroundColor;

    return Consumer<StatisticsProvider>(
      builder: (_, provider, __) {
        return provider.monthDocList!.isNotEmpty &&
                provider.filteredCategoryList!.isNotEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: SizedBox(
                    height: 102,
                    width: 102,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              provider.updateTouchedIndex(-1);

                              return;
                            }
                            var ind = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                            provider.updateTouchedIndex(ind);
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 30,
                        sections: provider.filteredCategoryList!.map(
                          (e) {
                            String time =
                                e.lastUpdateTimeString.split(' ').last;

                            int hr = int.tryParse(time.split(':').first)!;
                            int min = int.tryParse(time.split(":")[1])!;
                            int sec = int.tryParse(time.split(':').last)!;
                            var red = hr + min + sec;
                            var grn = min + hr + 150;
                            var blu = 2 * hr + sec + 100;

                            return PieChartSectionData(
                              color: Color.fromRGBO(
                                red,
                                grn,
                                blu,
                                1,
                              ),
                              value: double.parse(
                                e.totalAmount.toString(),
                              ),
                              title: e.categoryName,
                              radius: 40,
                              titleStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffffffff),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  'No Categories !',
                  style: TextStyle(
                    color: bgColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              );
      },
    );
  }
}
