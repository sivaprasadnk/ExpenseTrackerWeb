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
      bottomButton: const Padding(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: ApplyButton(),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 1.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            DarkThemeCheckBox(),
            SizedBox(
              height: 10,
            ),
            ThemeGrid(),
            // Expanded(
            //   child: Container(),
            // ),
            // ApplyButton(),
          ],
        ),
      ),
      appBarTitle: 'Select Theme',
    );
  }
}
