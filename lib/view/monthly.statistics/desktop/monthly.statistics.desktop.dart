import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/categories.filter.container.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/monthly.summary.container.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/pie.chart.category.data.desktop.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/view.all.text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'categories.filter.container.dart';
import 'categories.list.dart';

class MonthlyStatisticsScreenDesktop extends StatelessWidget {
  const MonthlyStatisticsScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return DesktopView(
      child: Center(
        child: Container(
          width: 430,
          height: height * 0.9,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MonthlySummaryContainer(),
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
                      const CategoriesFilterContainer(),
                      const SizedBox(height: 10),
                      const Text('Categories').boldPrimaryColorText(context),
                      const SizedBox(height: 40),
                      const PieChartCategoryDataDesktop(),
                      const ViewAllCategoriesText(),
                      const SizedBox(height: 15),
                      const TransactionCategoriesList(),
                      const SizedBox(height: 20),
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
