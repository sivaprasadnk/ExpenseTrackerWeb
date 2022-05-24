import 'package:expense_tracker/provider/dark.theme.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkThemeCheckBox extends StatelessWidget {
  const DarkThemeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dark Theme'),
          Consumer<DarkThemeProvider>(
            builder: (_, provider, __) {
              return Checkbox(
                value: provider.isDarkTheme,
                onChanged: (val) {
                  provider.updateDarkThemeStatus(val!);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
