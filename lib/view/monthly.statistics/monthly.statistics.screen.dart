import 'package:expense_tracker/utils/responsive.screen.dart';
import 'package:flutter/material.dart';

import 'desktop/monthly.statistics.desktop.dart';
import 'mobile/monthly.statistics.mobile.dart';

class MonthlyStatisticsScreen extends StatefulWidget {
  const MonthlyStatisticsScreen({Key? key}) : super(key: key);
  static const routeName = 'MonthlyStatistics';
  @override
  _MonthlyStatisticsScreenState createState() =>
      _MonthlyStatisticsScreenState();
}

class _MonthlyStatisticsScreenState extends State<MonthlyStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(
      desktopScreen: MonthlyStatisticsScreenDesktop(),
      tabletScreen: MonthlyStatisticsScreenMobile(),
      mobileScreen: MonthlyStatisticsScreenMobile(),
    );
  }
}
