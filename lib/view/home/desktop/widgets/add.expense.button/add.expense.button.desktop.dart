import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/add_expense/add.expense.windows.small.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;

    // final screenHeight = screenSize.height;
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
                builder: (ctx) => const WindowsSmallAddExpenseScreen()));
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
        child: const Center(
          child: Text(
            'Add ',
            style: TextStyle(
              // fontFamily: 'Rajdhani',
              // color: isHovered
              //     ? theme.themeData.splashColor
              //     : Theme.of(context).textTheme.bodyMedium!.color!,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
