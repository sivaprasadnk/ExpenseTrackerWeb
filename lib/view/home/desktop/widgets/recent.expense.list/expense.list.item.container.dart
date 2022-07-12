import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionListItemContainer extends StatefulWidget {
  const TransactionListItemContainer({
    Key? key,
    required this.amount,
    required this.subTitle,
    required this.title,
    required this.type,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String amount;
  final String type;

  @override
  State<TransactionListItemContainer> createState() =>
      _TransactionListItemContainerState();
}

class _TransactionListItemContainerState
    extends State<TransactionListItemContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    var primaryColor = theme.primaryColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    var drOrCr = "+";
    if (widget.type == "Expense") {
      drOrCr = "-";
    }
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                ),
              ),
              width: 4,
              height: 50,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "$drOrCr $currency ${widget.amount}",
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: primaryColor,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
