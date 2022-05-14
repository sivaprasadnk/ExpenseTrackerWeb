import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListItemContainer extends StatelessWidget {
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
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              width: 3,
              height: 40,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Rajdhani',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Rajdhani',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "$kRupeeSymbol ${amount}",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rajdhani',
              ),
            ),
            SizedBox(width: 20),
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
