import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/select.theme/widgets/apply.button.dart';
import 'package:expense_tracker/view/select.theme/widgets/dark.theme.check.box.dart';
import 'package:expense_tracker/view/select.theme/widgets/theme.grid.dart';
import 'package:flutter/material.dart';

class SelectThemeDesktopScreen extends StatelessWidget {
  const SelectThemeDesktopScreen({Key? key}) : super(key: key);
  static const routeName = '/SelectTheme';
  @override
  Widget build(BuildContext context) {
    return DesktopView(
      isHome: false,

      topPadding: 50,
      child: Center(
        child: SizedBox(
          width: 450,
          child: ListView(
            children: const [
              DarkThemeCheckBox(),
              SizedBox(
                height: 20,
              ),
              ThemeGrid(),
              SizedBox(
                height: 50,
              ),
              ApplyButton(),
            ],
          ),
        ),
      ),
      appBarTitle: 'Select Theme',
    );
  }
}
