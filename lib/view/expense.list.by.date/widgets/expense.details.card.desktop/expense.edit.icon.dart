import 'package:expense_tracker/model/expense.model.dart';
import 'package:flutter/material.dart';

class ExpenseEditIcon extends StatelessWidget {
  const ExpenseEditIcon({Key? key, required this.expense}) : super(key: key);
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return Positioned.fill(
      top: 20,
      right: 0,
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
          },
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.edit,
                size: 10,
                color: bgColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
