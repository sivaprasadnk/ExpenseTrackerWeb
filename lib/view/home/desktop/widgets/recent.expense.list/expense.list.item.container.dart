import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
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
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
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
                    // fontFamily: 'Rajdhani',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    // fontFamily: 'Rajdhani',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "$kRupeeSymbol ${widget.amount}",
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                // fontFamily: 'Rajdhani',
              ),
            ),
            const SizedBox(width: 20),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
