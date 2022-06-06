import 'package:flutter/material.dart';

class ExpenseCategoryNameContainer extends StatelessWidget {
  const ExpenseCategoryNameContainer({Key? key, required this.categoryName})
      : super(key: key);
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
