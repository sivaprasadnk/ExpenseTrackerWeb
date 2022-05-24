import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/expense.date.list/desktop/small/expense.by.date.desktop.small.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return InkWell(
      onHover: (val) {
        setState(() {
          isHovered = val;
        });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const ExpenseDateListDesktopSmall()),
        );
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
              ' by Date',
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
