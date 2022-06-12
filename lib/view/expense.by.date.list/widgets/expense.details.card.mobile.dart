import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.amount.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.category.name.container.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.date.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.mode.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.title.text.dart';
import 'package:flutter/material.dart';

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
          height: 106,
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
                  const SizedBox(
                    height: 10,
                  ),
                  ExpenseCategoryNameContainer(
                      categoryName: expense.categoryName),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        ExpenseAmountText(amount: expense.amount.toString()),
        ExpenseModeText(mode: expense.mode),
        ExpenseTitleText(title: expense.expenseTitle),
      ],
    );
  }
}
