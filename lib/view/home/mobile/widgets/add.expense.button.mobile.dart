import 'package:expense_tracker/view/add_expense/add.expense.mobile.dart';
import 'package:flutter/material.dart';

class AddExpenseButtonMobile extends StatelessWidget {
  const AddExpenseButtonMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var primaryColor = theme.primaryColor;

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AddExpenseMobile.routeName);
      },
      child: Container(
        height: 150,
        width: screenWidth / 3 - 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Add ',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
