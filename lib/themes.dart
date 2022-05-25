import 'package:expense_tracker/no.transitions.builder.dart';
import 'package:flutter/foundation.dart';
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
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              // No animations for every OS if the app running on the web
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : const {
              // handel other platforms you are targeting
            },
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(254, 246, 228, 1),
    ),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Rajdhani',
        fontSize: 20,
      ),
    ),
    splashColor: Colors.white,
    cardColor: const Color.fromRGBO(245, 130, 174, 1),
    primaryColor: const Color.fromRGBO(0, 24, 88, 1),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Rajdhani',
        color: Color.fromRGBO(0, 24, 88, 1),
      ),
    ),
    secondaryHeaderColor: const Color.fromARGB(255, 150, 101, 73),
    scaffoldBackgroundColor: const Color.fromRGBO(254, 246, 228, 1),
  ),

  /// second
  AppTheme.brown: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              // No animations for every OS if the app running on the web
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : const {
              // handel other platforms you are targeting
            },
    ),
    brightness: Brightness.dark,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(85, 66, 61, 1),
    ),
    splashColor: const Color.fromARGB(255, 230, 193, 171),
    cardColor: const Color.fromARGB(255, 172, 125, 111),
    primaryColor: const Color.fromRGBO(255, 243, 236, 1),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(255, 243, 236, 1),
        fontFamily: 'Rajdhani',
      ),
    ),
    secondaryHeaderColor: const Color.fromARGB(255, 47, 223, 214),
    scaffoldBackgroundColor: const Color.fromRGBO(85, 66, 61, 1),
  ),

  /// third
  AppTheme.purple: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              // No animations for every OS if the app running on the web
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : const {
              // handel other platforms you are targeting
            },
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(35, 41, 70, 1),
    ),
    brightness: Brightness.dark,
    cardColor: const Color.fromRGBO(238, 187, 195, 1),
    splashColor: const Color.fromARGB(255, 110, 115, 143),
    primaryColor: const Color.fromRGBO(184, 193, 236, 1),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(184, 193, 236, 1),
        fontFamily: 'Rajdhani',
      ),
    ),
    secondaryHeaderColor: const Color.fromARGB(255, 150, 101, 73),
    scaffoldBackgroundColor: const Color.fromRGBO(35, 41, 70, 1),
  ),

  ///  fourth
  AppTheme.green: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              // No animations for every OS if the app running on the web
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : const {
              // handel other platforms you are targeting
            },
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(0, 70, 67, 1),
    ),
    brightness: Brightness.dark,
    cardColor: const Color.fromRGBO(249, 188, 96, 1),
    splashColor: const Color.fromARGB(255, 74, 145, 125),
    primaryColor: const Color.fromRGBO(171, 209, 198, 1),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(171, 209, 198, 1),
        fontFamily: 'Rajdhani',
      ),
    ),
    secondaryHeaderColor: const Color.fromARGB(255, 150, 101, 73),
    scaffoldBackgroundColor: const Color.fromRGBO(0, 70, 67, 1),
  ),

  AppTheme.grey: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              // No animations for every OS if the app running on the web
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : const {
              // handel other platforms you are targeting
            },
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(247, 204, 172, 1),
    ),
    brightness: Brightness.light,
    cardColor: const Color.fromARGB(255, 189, 161, 101),
    splashColor: const Color.fromARGB(255, 94, 88, 129),
    primaryColor: const Color.fromRGBO(58, 56, 69, 1),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(58, 56, 69, 1),
        fontFamily: 'Rajdhani',
      ),
    ),
    secondaryHeaderColor: const Color.fromARGB(255, 150, 101, 73),
    scaffoldBackgroundColor: const Color.fromRGBO(247, 204, 172, 1),
  ),

  AppTheme.cream1: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              // No animations for every OS if the app running on the web
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : const {
              // handel other platforms you are targeting
            },
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(212, 236, 221, 1),
    ),
    brightness: Brightness.light,
    cardColor: const Color.fromARGB(255, 41, 196, 207),
    primaryColor: const Color.fromRGBO(52, 91, 99, 1),
    // hoverColor: ,
    splashColor: const Color.fromARGB(255, 55, 149, 168),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color.fromRGBO(52, 91, 99, 1),
        fontFamily: 'Rajdhani',
      ),
    ),
    secondaryHeaderColor: const Color.fromARGB(255, 150, 101, 73),

    scaffoldBackgroundColor: const Color.fromRGBO(212, 236, 221, 1),
  ),
};

String enumName(AppTheme kEnum) {
  return kEnum.toString().split('.')[1];
}
