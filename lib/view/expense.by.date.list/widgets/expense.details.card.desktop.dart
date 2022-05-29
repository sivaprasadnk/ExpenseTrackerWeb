import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.amount.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.category.name.container.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.created.date.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.mode.text.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.title.text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseDetailsCardDesktop extends StatelessWidget {
  const ExpenseDetailsCardDesktop({
    Key? key,
    required this.expense,
    this.width = double.infinity,
  }) : super(key: key);
  final Expense expense;
  final double width;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context, listen: false).themeData;
    var primaryColor = theme.primaryColor;
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          height: 104,
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
                  ExpenseCreatedDateText(
                    createdDate: expense.createdDate,
                  ),
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
