import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.edit.icon.dart';
import 'package:flutter/material.dart';

import 'expense.amount.text.dart';
import 'expense.category.name.container.dart';
import 'expense.date.text.dart';
import 'expense.details.text.dart';
import 'expense.mode.text.dart';
import 'expense.title.text.dart';

class ExpenseDetailsCardDesktop extends StatelessWidget {

  const ExpenseDetailsCardDesktop({
    Key? key,
    required this.transaction,
    this.width = double.infinity,
  }) : super(key: key);
  
  final TransactionModel transaction;
  
  final double width;
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.only(left: 10, top: 10),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            border: Border.all(
              color: primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  ExpenseDetailsText(
                    details: expense.details,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ExpenseDateText(
                    date: expense.expenseDay,
                    month: expense.expenseMonth,
                  ),
                  const SizedBox(height: 10),
                  ExpenseCategoryNameContainer(
                      categoryName: expense.categoryName),
                  const SizedBox(height: 10),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        ExpenseAmountText(amount: expense.amount.toString()),
        ExpenseModeText(mode: expense.mode),
        ExpenseEditIcon(expense: expense),
        ExpenseTitleText(title: expense.expenseTitle),
      ],
    );
  }
}
