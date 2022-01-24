import 'package:flutter/material.dart';

class RouteProvider extends ChangeNotifier {
  String screenName = "Home";
  bool menuSelectedCheck = false;

  RouteProvider({required this.screenName, required this.menuSelectedCheck});

  String get screen => screenName;

  bool get menuSelected => menuSelectedCheck;

  setScreen({required String name}) {
    screenName = name;
    notifyListeners();
  }

  setMenuSelected({required bool check}) {
    menuSelectedCheck = check;
    notifyListeners();
  }
}
