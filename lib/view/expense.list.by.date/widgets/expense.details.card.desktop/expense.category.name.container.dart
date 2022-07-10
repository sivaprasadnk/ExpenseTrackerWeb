import 'package:flutter/material.dart';

class ExpenseCategoryNameContainer extends StatelessWidget {
  const ExpenseCategoryNameContainer({
    Key? key,
    required this.categoryName,
    this.fontSize = 15,
  }) : super(key: key);
  final String categoryName;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0) +
            const EdgeInsets.symmetric(horizontal: 7),
        child: Text(
          categoryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
