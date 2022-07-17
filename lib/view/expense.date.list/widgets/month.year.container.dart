
import 'package:flutter/material.dart';

class MonthYearContainer extends StatelessWidget {
  const MonthYearContainer({
    Key? key,
    required this.month,
    required this.year,
  }) : super(key: key);

  final String month;
  final String year;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              month + ", " + year,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}