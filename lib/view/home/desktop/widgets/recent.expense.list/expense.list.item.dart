import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.details.card.desktop.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.mobile/expense.details.card.mobile.dart';
import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/expense.list.item.container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    Key? key,
    required this.expense,
  }) : super(key: key);
  final RecentExpense expense;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Expense exp = Expense.fromRecentExpense(expense);
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
                    ExpenseDetailsCardMobile(
                      expense: exp,
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
                        ExpenseDetailsCardDesktop(
                          expense: exp,
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
      child: ExpenseListItemContainer(
        title: expense.expenseTitle,
        amount: expense.amount.toString(),
        subTitle: expense.categoryName,
      ),
    );
  }
}
