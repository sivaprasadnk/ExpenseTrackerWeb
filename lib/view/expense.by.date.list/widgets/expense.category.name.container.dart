import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryNameContainer extends StatelessWidget {
  const ExpenseCategoryNameContainer({Key? key, required this.categoryName})
      : super(key: key);
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context, listen: false).themeData;
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0) +
            const EdgeInsets.symmetric(horizontal: 3),
        child: Text(
          categoryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
