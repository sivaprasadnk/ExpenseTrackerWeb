import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/view/home/tablet/expense.details.card.tablet.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'recent.expense.list.item.container.tablet.dart';

class RecentExpenseListItemTablet extends StatelessWidget {
  const RecentExpenseListItemTablet({
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

        showDialog(
          barrierDismissible: false,
          context: context,
          barrierColor: Colors.black87,
          builder: (_) {
            return Center(
              child: SizedBox(
                width: width * .9,
                child: Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                  elevation: 0,
                  backgroundColor: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ExpenseDetailsCardTablet(
                        expense: exp,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: 3.h,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 4.h,
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
      },
      child: RecentExpenseListItemContainerTablet(
        title: expense.expenseTitle,
        amount: expense.amount.toString(),
        subTitle: expense.categoryName,
      ),
    );
  }
}
