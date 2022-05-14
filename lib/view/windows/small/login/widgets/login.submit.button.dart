import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return Container(
      height: 40,
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
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: theme.themeData.scaffoldBackgroundColor,
            fontFamily: 'Rajdhani',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
