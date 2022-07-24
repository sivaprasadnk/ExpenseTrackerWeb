import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/provider/statistics.provider.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/view.transactions.container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionCategoriesList extends StatelessWidget {
  const TransactionCategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;

    return Consumer<StatisticsProvider>(
      builder: (_, provider, __) {
        return SizedBox(
          height: 140,
          width: 430,
          child: provider.monthDocList!.isNotEmpty &&
                  provider.filteredCategoryList!.isNotEmpty
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: provider.filteredCategoryList!.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, index) {
                    TransactionCategoryModel cat =
                        provider.filteredCategoryList![index];
                    return Stack(
                      children: [
                        Container(
                          height: 130,
                          width: 120,
                          margin: const EdgeInsets.only(bottom: 15, top: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: primaryColor,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(45),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  cat.categoryName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('$currency ${cat.totalAmount}')
                                    .boldPrimaryColorText(context),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          top: 10,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  cat.categoryName[0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: bgColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ViewTransactionsContainer(
                            selectedType: provider.selectedType, category: cat),
                      ],
                    );
                  },
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
