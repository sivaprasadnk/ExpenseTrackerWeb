import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkThemeCheckBox extends StatelessWidget {
  const DarkThemeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 1,
        ),
        Consumer<ThemeNotifier>(
          builder: (_, provider, __) {
            return Checkbox(
              fillColor:
                  MaterialStateProperty.all(provider.themeData.primaryColor),
              checkColor: provider.themeData.scaffoldBackgroundColor,
              value: provider.themeData.brightness == Brightness.dark,
              onChanged: (val) {
                provider.toggleBrightness();
              },
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          'Dark Theme',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
