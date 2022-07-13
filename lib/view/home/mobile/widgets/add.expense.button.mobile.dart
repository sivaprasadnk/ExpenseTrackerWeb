import 'package:expense_tracker/view/add.transaction/add.transaction.mobile.dart';
import 'package:flutter/material.dart';

class AddExpenseButtonMobile extends StatelessWidget {
  const AddExpenseButtonMobile({Key? key, required this.height})
      : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var primaryColor = theme.primaryColor;

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AddTransactionMobile.routeName);
      },
      child: Container(
        height: height,
        width: screenWidth / 3 - 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Add \n Expense',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
