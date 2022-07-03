import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListItemContainer extends StatefulWidget {
  const ExpenseListItemContainer({
    Key? key,
    required this.amount,
    required this.subTitle,
    required this.title,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String amount;

  @override
  State<ExpenseListItemContainer> createState() =>
      _ExpenseListItemContainerState();
}

class _ExpenseListItemContainerState extends State<ExpenseListItemContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    var primaryColor = theme.primaryColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
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
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              width: 3,
              height: 40,
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
              "$currency ${widget.amount}",
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20),
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
