import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseTitleText extends StatelessWidget {
  const ExpenseTitleText({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context, listen: false).themeData;
    var primaryColor = theme.primaryColor;
    final width = MediaQuery.of(context).size.width;
    return Positioned.fill(
      left: 20,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            title,
            style: const TextStyle(
              // fontFamily: 'Rajdhani',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
