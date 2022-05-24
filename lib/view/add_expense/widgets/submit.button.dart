import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, this.width = 450}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return Container(
      height: 50,
      width: width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Submit',
          style: TextStyle(
            fontSize: 20,
            color: theme.themeData.scaffoldBackgroundColor,
            // fontFamily: 'Rajdhani',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}