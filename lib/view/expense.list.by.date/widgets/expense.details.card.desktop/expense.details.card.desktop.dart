import 'package:expense_tracker/model/transaction.model.dart';
import 'package:flutter/material.dart';

import 'expense.amount.text.dart';
import 'expense.category.name.container.dart';
import 'expense.date.text.dart';
import 'expense.details.text.dart';
import 'expense.title.text.dart';

class TransactionDetailsCardDesktop extends StatelessWidget {

  const TransactionDetailsCardDesktop({
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
                    details: transaction.details,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ExpenseDateText(
                    date: transaction.transactionDay,
                    month: transaction.transactionMonth,
                  ),
                  const SizedBox(height: 10),
                  ExpenseCategoryNameContainer(
                      categoryName: transaction.categoryName),
                  const SizedBox(height: 10),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        ExpenseAmountText(amount: transaction.amount.toString()),
        // ExpenseModeText(mode: expense.mode),
        // ExpenseEditIcon(transaction: expense),
        ExpenseTitleText(title: transaction.title),
      ],
    );
  }
}
