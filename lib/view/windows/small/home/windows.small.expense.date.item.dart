import 'package:expense_tracker/view/windows/small/expense_details/windows.small.expense_details.dart';
import 'package:flutter/material.dart';

class WindowsSmallExpenseDateItem extends StatelessWidget {
  const WindowsSmallExpenseDateItem({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => WindowsSmallExpenseDetails(title: title)));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.cyan,
          ),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}
