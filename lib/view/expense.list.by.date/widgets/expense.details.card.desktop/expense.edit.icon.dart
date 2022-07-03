import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/view/edit.expense/edit.expense.desktop.dart';
import 'package:expense_tracker/view/edit.expense/edit.expense.mobile.dart';
import 'package:flutter/foundation.dart';
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
              if ((defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS)) {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return EditExpenseScreenMobile(
                    expense: expense,
                  );
                })));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return EditExpenseScreenDesktop(
                    expense: expense,
                  );
                })));
              }

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
