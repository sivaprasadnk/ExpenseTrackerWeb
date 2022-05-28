import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/select.theme/select.theme.desktop.screen.dart';
import 'package:flutter/material.dart';

class SelectThemeMobileScreen extends StatelessWidget {
  const SelectThemeMobileScreen({Key? key}) : super(key: key);
  static const routeName = '/SelectThemeScreen';

  @override
  Widget build(BuildContext context) {
    return MobileView(
      child: ListView(
        children: const [
          ThemeGrid(),
          SizedBox(
            height: 50,
          ),
          ApplyButton(),
        ],
      ),
      appBarTitle: 'Select Theme',
    );
  }
}
