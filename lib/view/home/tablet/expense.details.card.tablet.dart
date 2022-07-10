import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.amount.text.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.category.name.container.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.date.text.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.details.text.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.edit.icon.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.mode.text.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.title.text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExpenseDetailsCardTablet extends StatelessWidget {
  const ExpenseDetailsCardTablet({
    Key? key,
    required this.expense,
  }) : super(key: key);
  final Expense expense;
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
                  SizedBox(
                    height: 3.h,
                  ),
                  ExpenseDetailsText(
                    details: expense.details,
                    fontSize: 10.sp,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ExpenseDateText(
                    date: expense.expenseDay,
                    month: expense.expenseMonth,
                    fontSize: 10.sp,
                  ),
                  const SizedBox(height: 10),
                  ExpenseCategoryNameContainer(
                    categoryName: expense.categoryName,
                    fontSize: 10.sp,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        ExpenseAmountText(amount: expense.amount.toString()),
        ExpenseModeText(
          mode: expense.mode,
          fontSize: 11.sp,
          rightPadding: 7.w,
        ),
        ExpenseEditIcon(
          expense: expense,
          size: 4.w,
        ),
        ExpenseTitleText(
          title: expense.expenseTitle,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}
