import 'package:flutter/material.dart';

enum AppTheme {
  cream,
  grey,
  cream1,
  brown,
  purple,
  green,
}
final appThemeData = {
  /// first
  AppTheme.cream: ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromRGBO(254, 246, 228, 1),
    ),
    brightness: Brightness.light,
    cardColor: Color.fromRGBO(245, 130, 174, 1),
    primaryColor: Color.fromRGBO(0, 24, 88, 1),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(0, 24, 88, 1),
      ),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(254, 246, 228, 1),
  ),

  /// second
  AppTheme.brown: ThemeData(
    brightness: Brightness.dark,
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromRGBO(85, 66, 61, 1),
    ),
    cardColor: Color.fromRGBO(255, 192, 173, 1),
    primaryColor: const Color.fromRGBO(255, 243, 236, 1),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(255, 243, 236, 1),
      ),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(85, 66, 61, 1),
  ),

  /// third
  AppTheme.purple: ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromRGBO(35, 41, 70, 1),
    ),
    brightness: Brightness.dark,
    cardColor: Color.fromRGBO(238, 187, 195, 1),
    primaryColor: const Color.fromRGBO(184, 193, 236, 1),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(184, 193, 236, 1),
      ),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(35, 41, 70, 1),
  ),

  ///  fourth
  AppTheme.green: ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromRGBO(0, 70, 67, 1),
    ),
    brightness: Brightness.dark,
    cardColor: Color.fromRGBO(249, 188, 96, 1),
    primaryColor: const Color.fromRGBO(171, 209, 198, 1),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(171, 209, 198, 1),
      ),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(0, 70, 67, 1),
  ),

  /// fifth
  // AppTheme.grey: ThemeData(
  //   drawerTheme: DrawerThemeData(
  //     backgroundColor: Color.fromRGBO(58, 56, 69, 1),
  //   ),
  //   brightness: Brightness.dark,
  //   cardColor: Color.fromRGBO(249, 188, 96, 1),
  //   primaryColor: const Color.fromRGBO(171, 209, 198, 1),
  //   textTheme: TextTheme(
  //     bodyMedium: TextStyle(
  //       color: Color.fromRGBO(171, 209, 198, 1),
  //     ),
  //   ),
  //   scaffoldBackgroundColor: Color.fromRGBO(58, 56, 69, 1),
  // ),

  AppTheme.grey: ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromRGBO(247, 204, 172, 1),
    ),
    brightness: Brightness.light,
    cardColor: Color.fromRGBO(58, 56, 69, 1),
    primaryColor: const Color.fromRGBO(58, 56, 69, 1),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: const Color.fromRGBO(58, 56, 69, 1),
      ),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(247, 204, 172, 1),
  ),

  /// sixth
  // AppTheme.cream1: ThemeData(
  //   drawerTheme: DrawerThemeData(
  //     backgroundColor: Color.fromRGBO(7, 34, 39, 1),
  //   ),
  //   brightness: Brightness.dark,
  //   cardColor: Color.fromRGBO(53, 133, 139, 1),
  //   primaryColor: const Color.fromRGBO(171, 209, 198, 1),
  //   textTheme: TextTheme(
  //     bodyMedium: TextStyle(
  //       color: Color.fromRGBO(171, 209, 198, 1),
  //     ),
  //   ),
  //   scaffoldBackgroundColor: Color.fromRGBO(7, 34, 39, 1),
  // ),

  AppTheme.cream1: ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromRGBO(212, 236, 221, 1),
    ),
    brightness: Brightness.light,
    cardColor: Color.fromRGBO(53, 133, 139, 1),
    primaryColor: const Color.fromRGBO(52, 91, 99, 1),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: const Color.fromRGBO(52, 91, 99, 1),
      ),
    ),
    scaffoldBackgroundColor: Color.fromRGBO(212, 236, 221, 1),
  ),
};

String enumName(AppTheme kEnum) {
  return kEnum.toString().split('.')[1];
}
