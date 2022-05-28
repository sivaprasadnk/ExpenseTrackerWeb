import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/add_expense/add.expense.mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoExpenseContainerMobile extends StatelessWidget {
  const NoExpenseContainerMobile({Key? key, required this.title})
      : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return Consumer<ThemeNotifier>(
      builder: (_, provider, __) {
        var theme = provider.themeData;
        return SizedBox(
          height: screenHeight * 0.5,
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  title ?? 'No Expenses added for today!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 135,
                  child: CursorWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const AddExpenseMobile()));
                    },
                    isButton: true,
                    bgColor: theme.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Add Expense',
                            style: TextStyle(
                              color: theme.scaffoldBackgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.add,
                            size: 20,
                            color: theme.scaffoldBackgroundColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
