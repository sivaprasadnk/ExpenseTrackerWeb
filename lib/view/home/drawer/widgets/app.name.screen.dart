import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppNameScreen extends StatelessWidget {
  const AppNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context, listen: false).themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          height: 260,
          width: 260,
          child: const FittedBox(
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                'Expense\nTracker',
                style: TextStyle(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
