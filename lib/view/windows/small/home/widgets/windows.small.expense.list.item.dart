import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/expense.list.item.dart';
import 'package:expense_tracker/view/windows/small/recent/recent.expense.details.dart';
import 'package:flutter/material.dart';

class WindowsSmallExpenseListItem extends StatelessWidget {
  const WindowsSmallExpenseListItem({
    Key? key,
    required this.expense,
  }) : super(key: key);
  final RecentExpense expense;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => RecentExpenseDetails(
                        expense: expense,
                      )));
        },
        child: ExpenseListItemContainer(
          title: expense.expenseTitle,
          amount: expense.amount.toString(),
          subTitle: expense.categoryName,
        ));
  }
}
