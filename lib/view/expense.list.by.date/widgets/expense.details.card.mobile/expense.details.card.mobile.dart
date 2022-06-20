import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.edit.icon.dart';
import 'package:flutter/material.dart';

import '../expense.details.card.desktop/expense.amount.text.dart';
import '../expense.details.card.desktop/expense.category.name.container.dart';
import '../expense.details.card.desktop/expense.date.text.dart';
import '../expense.details.card.desktop/expense.details.text.dart';
import '../expense.details.card.desktop/expense.mode.text.dart';
import '../expense.details.card.desktop/expense.title.text.dart';

class ExpenseDetailsCardMobile extends StatelessWidget {
  const ExpenseDetailsCardMobile({
    Key? key,
    required this.expense,
    this.width = double.infinity,
  }) : super(key: key);
  final Expense expense;
  final double width;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
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
                  // ExpenseCreatedDateText(
                  //   createdDate: expense.createdDate,
                  // ),
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
