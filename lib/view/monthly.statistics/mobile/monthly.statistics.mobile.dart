import 'package:expense_tracker/provider/statistics.provider.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/categories.filter.container.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/categories.list.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/daily.summary.container.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/monthly.summary.container.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/view.all.text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'pie.chart.category.data.mobile.dart';

class MonthlyStatisticsScreenMobile extends StatelessWidget {
  const MonthlyStatisticsScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return MobileView(
      child: Center(
        child: Container(
          width: 430,
          height: height * 0.9,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<StatisticsProvider>(
                    builder: (_, provider, __) {
                      return GestureDetector(
                        onTap: () {
                          provider.updateView(ViewType.monthly);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor,
                            ),
                            color: provider.selectedView == ViewType.monthly
                                ? primaryColor
                                : bgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
                            child: provider.selectedView == ViewType.monthly
                                ? const Text('Monthly')
                                    .boldBgColorTextWithSize(context, 20)
                                : const Text('Monthly')
                                    .boldPrimaryColorTextWithSize(context, 20),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Consumer<StatisticsProvider>(
                    builder: (_, provider, __) {
                      return GestureDetector(
                        onTap: () {
                          provider.updateView(ViewType.daily);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor,
                            ),
                            color: provider.selectedView == ViewType.daily
                                ? primaryColor
                                : bgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
                            child: provider.selectedView == ViewType.daily
                                ? const Text('Daily')
                                    .boldBgColorTextWithSize(context, 20)
                                : const Text('Daily')
                                    .boldPrimaryColorTextWithSize(context, 20),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Consumer<StatisticsProvider>(
                builder: (_, provider, __) {
                  return provider.selectedView == ViewType.monthly
                      ? const MonthlySummaryContainer()
                      : const DailySummaryContainer();
                },
              ),
              // const MonthlySummaryContainer(),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: 430,
                  padding:
                      const EdgeInsets.all(6) + const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(
                      width: 2,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),

                      const CategoriesFilterContainer(),
                      const Spacer(),
                      const Text('Categories ')
                          .boldPrimaryColorTextWithSize(context, 20),
                      // SizedBox(height: 5.h),
                      const Spacer(),
                      // const Spacer(),

                      const PieChartCategoryDataMobile(),
                      SizedBox(height: 5.h),
                      const ViewAllCategoriesText(),
                      const TransactionCategoriesList(),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2)
            ],
          ),
        ),
      ),
      appBarTitle: '',
      isHome: false,
    );
  }

  IconData getIcon(String category) {
    switch (category) {
      case "AutoFare":
        return FontAwesomeIcons.taxi;
      case "BusFare":
        return FontAwesomeIcons.taxi;
      case "BottleWater":
        return FontAwesomeIcons.bottleWater;
      case "Food":
        return FontAwesomeIcons.bowlFood;
      default:
        return FontAwesomeIcons.googlePay;
    }
  }
}
