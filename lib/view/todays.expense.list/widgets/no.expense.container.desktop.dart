import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/add_expense/add.expense.windows.small.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoExpenseContainerDesktop extends StatelessWidget {
  const NoExpenseContainerDesktop(
      {Key? key,
      this.height,
      this.title,
      this.initSpace,
      this.showAddButton = false})
      : super(key: key);
  final double? height;
  final String? title;
  final double? initSpace;
  final bool? showAddButton;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return Consumer<ThemeNotifier>(
      builder: (_, provider, __) {
        var theme = provider.themeData;
        return SizedBox(
          height: height ?? screenHeight * 0.5,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: initSpace ?? screenHeight * 0.12,
                ),
                Text(
                  title ?? 'No Expenses added today!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    // color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (showAddButton!)
                  SizedBox(
                    width: 135,
                    child: CursorWidget(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AddExpenseScreenDesktop.routeName);
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
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
