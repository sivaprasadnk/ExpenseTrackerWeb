import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.details.card.desktop.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.mobile/expense.details.card.mobile.dart';
import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/expense.list.item.container.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Expense exp = Expense.fromRecentExpense(expense);
            double width = MediaQuery.of(context).size.width;

        if (width<480) {
          showDialog(
            barrierDismissible: false,
            context: context,
            barrierColor: Colors.black87,
            builder: (_) {
              return Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Colors.black12,
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TransactionDetailsCardMobile(
                      transaction: transaction,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            barrierColor: Colors.black87,
            builder: (_) {
              return Center(
                child: SizedBox(
                  width: 450,
                  child: Dialog(
                    insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                    elevation: 0,
                    backgroundColor: Colors.black12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TransactionDetailsCardDesktop(
                          transaction: transaction,
                          width: 450,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      child: TransactionListItemContainer(
        title: transaction.title,
        type: transaction.transactionType,
        amount: transaction.amount.toString(),
        subTitle: transaction.categoryName,
      ),
    );
  }
}
