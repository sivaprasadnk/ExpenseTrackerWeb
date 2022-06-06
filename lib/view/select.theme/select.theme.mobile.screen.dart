import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/select.theme/widgets/apply.button.dart';
import 'package:expense_tracker/view/select.theme/widgets/dark.theme.check.box.dart';
import 'package:expense_tracker/view/select.theme/widgets/theme.grid.dart';
import 'package:flutter/material.dart';

class SelectThemeMobileScreen extends StatelessWidget {
  const SelectThemeMobileScreen({Key? key}) : super(key: key);
  static const routeName = '/SelectThemeScreen';

  @override
  Widget build(BuildContext context) {
    return MobileView(
      showNetworkStatus: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DarkThemeCheckBox(),
          const SizedBox(
            height: 20,
          ),
          const ThemeGrid(),
          Expanded(
            child: Container(),
          ),
          const ApplyButton(),
        ],
      ),
      appBarTitle: 'Select Theme',
    );
  }
}
