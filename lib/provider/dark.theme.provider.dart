import 'package:flutter/cupertino.dart';

class DarkThemeProvider extends ChangeNotifier {
  bool isDarkTheme_ = true;
  bool get isDarkTheme => isDarkTheme_;

  void updateDarkThemeStatus(bool status) {
    isDarkTheme_ = status;
    notifyListeners();
  }
}
