import 'package:expense_tracker/model/transaction.model.dart';
import 'package:flutter/material.dart';

import '../expense.details.card.desktop/expense.amount.text.dart';
import '../expense.details.card.desktop/expense.category.name.container.dart';
import '../expense.details.card.desktop/expense.date.text.dart';
import '../expense.details.card.desktop/expense.details.text.dart';
import '../expense.details.card.desktop/expense.mode.text.dart';
import '../expense.details.card.desktop/expense.title.text.dart';

class TransactionDetailsCardMobile extends StatelessWidget {
  
  const TransactionDetailsCardMobile({
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
                    height: 12,
                  ),
                  ExpenseDetailsText(
                    details: transaction.details,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ExpenseDateText(
                    date: transaction.transactionDay,
                    month: transaction.transactionMonth,
                  ),
                  // ExpenseCreatedDateText(
                  //   createdDate: expense.createdDate,
                  // ),
                  const SizedBox(height: 10),
                  ExpenseCategoryNameContainer(
                      categoryName: transaction.categoryName),
                  // const SizedBox(height: 8),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        ExpenseAmountText(amount: transaction.amount.toString()),
        ExpenseModeText(mode: transaction.transactionType),
        // ExpenseEditIcon(expense: expense),
        ExpenseTitleText(title: transaction.title),
      ],
    );
  }
}
