import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/expense.by.category/expense.by.category.desktop.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
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
            color: isHovered ? theme.themeData.cardColor : primaryColor,
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
                // fontFamily: 'Rajdhani',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' by Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // fontFamily: 'Rajdhani',
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
