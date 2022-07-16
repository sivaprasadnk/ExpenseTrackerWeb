import 'package:expense_tracker/view/add.transaction/add.transaction.desktop.dart';
import 'package:flutter/material.dart';

class AddExpenseButtonDesktop extends StatefulWidget {
  const AddExpenseButtonDesktop({Key? key}) : super(key: key);

  @override
  State<AddExpenseButtonDesktop> createState() =>
      _AddExpenseButtonDesktopState();
}

class _AddExpenseButtonDesktopState extends State<AddExpenseButtonDesktop> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    var primaryColor = theme.primaryColor;

    // final screenHeight = screenSize.height;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onHover: (val) {
        setState(() {
          isHovered = val;
        });
      },
      onTap: () {
        Navigator.pushNamed(context, AddTransactionScreenDesktop.routeName);
      },
      child: Container(
        height: 150,
        width: 130,
        decoration: BoxDecoration(
          border: Border.all(
            width: isHovered ? 2 : 1,
            color: isHovered ? theme.cardColor : primaryColor,
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
