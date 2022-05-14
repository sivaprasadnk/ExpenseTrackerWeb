import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTextContainer extends StatelessWidget {
  const SettingsTextContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    final color = theme.themeData.primaryColor;
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.settings,
              size: 45,
            ),
            Text(
              'Settings',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 40,
                fontFamily: 'Rajdhani',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
