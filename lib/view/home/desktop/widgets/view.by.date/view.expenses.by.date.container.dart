import 'package:expense_tracker/view/expense.months/expense.months.desktop.dart';
import 'package:flutter/material.dart';

class ViewExpensesByDateContainer extends StatefulWidget {
  const ViewExpensesByDateContainer({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;

  @override
  State<ViewExpensesByDateContainer> createState() =>
      _ViewExpensesByDateContainerState();
}

class _ViewExpensesByDateContainerState
    extends State<ViewExpensesByDateContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return InkWell(
      onHover: (val) {
        setState(() {
          isHovered = val;
        });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ExpenseMonthsDesktop()),
        );
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'View Expenses',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' by Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
