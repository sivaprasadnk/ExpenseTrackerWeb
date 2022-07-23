import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/transaction.model.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key? key,
    required this.trans,
    this.showCategory = true,
  }) : super(key: key);

  final TransactionModel trans;
  final bool showCategory;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    var drOrCr = trans.transactionType == "Income" ? "+" : "-";
    double containerHeight = 85;
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: bgColor,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              width: 7,
              height: containerHeight,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      trans.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: bgColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (showCategory)
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    const SizedBox(width: 6),
                    if (showCategory)
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: bgColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          child: Text(
                            trans.categoryName,
                            style: TextStyle(
                              color: bgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                Text(
                  trans.details,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: bgColor,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: bgColor,
                    ),
                    Text(
                      trans.createdDateTimeString,
                      style: TextStyle(
                        color: bgColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              "$drOrCr $currency ${trans.amount}",
              style: TextStyle(
                fontSize: 35,
                color: bgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(width: 6),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
