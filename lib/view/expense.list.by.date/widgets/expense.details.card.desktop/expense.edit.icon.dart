import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/view/edit.expense/edit.expense.screen.dart';
import 'package:flutter/material.dart';

class ExpenseEditIcon extends StatelessWidget {
  const ExpenseEditIcon({
    Key? key,
    required this.expense,
    this.size = 10,
  }) : super(key: key);
  final Expense expense;
  final double size;
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
            var expenseDocId = expense.expenseDocId;
            var recentDocId = expense.recentDocId;
            if (expenseDocId.trim().isEmpty) {
              Dialogs.showAlertDialog(
                  context: context,
                  description: 'expense doc id is empty !. Cannot edit');
            } else if (recentDocId.trim().isEmpty) {
              Dialogs.showAlertDialog(
                  context: context,
                  description: 'recent doc id is empty !. Cannot edit');
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return EditExpenseScreen(
                      expense: expense,
                    );
                  }),
                ),
              );
            }
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
                size: size,
                color: bgColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
