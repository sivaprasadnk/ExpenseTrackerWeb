import 'package:expense_tracker/view/expense.by.category/expense.by.category.desktop.screen.dart';
import 'package:flutter/material.dart';

class ViewExpenseByCategoryContainer extends StatefulWidget {
  const ViewExpenseByCategoryContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewExpenseByCategoryContainer> createState() =>
      _ViewExpenseByCategoryContainerState();
}

class _ViewExpenseByCategoryContainerState
    extends State<ViewExpenseByCategoryContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const ExpenseByCategoryDesktopScreen()),
        );
      },
      onHover: (val) {
        setState(() {
          isHovered = val;
        });
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
              ' by Category',
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
