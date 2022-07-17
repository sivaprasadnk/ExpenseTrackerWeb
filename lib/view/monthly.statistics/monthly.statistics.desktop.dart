import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyStatisticsDesktop extends StatefulWidget {
  const MonthlyStatisticsDesktop({Key? key}) : super(key: key);

  @override
  State<MonthlyStatisticsDesktop> createState() =>
      _MonthlyStatisticsDesktopState();
}

class _MonthlyStatisticsDesktopState extends State<MonthlyStatisticsDesktop> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return DesktopView(
      child: Center(
        child: Container(
          width: 430,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 430,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      width: 1,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Monthly Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: bgColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Consumer<HomeProvider>(
                        builder: (_, provider, __) {
                          return Text(
                            "${provider.monthlyDrOrCr} ${provider.currencySymbol} ${provider.monthlyBalance}",
                            style: TextStyle(
                              height: 0.8,
                              fontSize: 53,
                              fontWeight: FontWeight.bold,
                              color: bgColor,
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Income',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: bgColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Consumer<HomeProvider>(
                                builder: (_, provider, __) {
                                  return Text(
                                    "${provider.currencySymbol} ${provider.monthlyTotalIncome}",
                                    style: TextStyle(
                                      height: 0.8,
                                      fontSize: 53,
                                      fontWeight: FontWeight.bold,
                                      color: bgColor,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          const SizedBox(width: 25),
                          Container(
                            height: 75,
                            width: 3,
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 25),
                          Column(
                            children: [
                              Text(
                                'Expense',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: bgColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Consumer<HomeProvider>(
                                builder: (_, provider, __) {
                                  return Text(
                                    "${provider.currencySymbol} ${provider.monthlyTotalExpense}",
                                    style: TextStyle(
                                      height: 0.8,
                                      fontSize: 53,
                                      fontWeight: FontWeight.bold,
                                      color: bgColor,
                                    ),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
                // const Spacer()
              ],
            ),
          ),
        ),
      ),
      appBarTitle: 'Statistics',
      isHome: false,
    );
  }
}
