import 'package:expense_tracker/no.transitions.builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  cream,
  maroon,
  green,

  brown,
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

  AppTheme.maroon: ThemeData(
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
    cardColor: const Color.fromARGB(255, 129, 56, 34),
    primaryColor: const Color(0xFF620E3D),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Rajdhani',
        color: Color(0xFF620E3D),
      ),
    ),
    secondaryHeaderColor: const Color.fromARGB(255, 150, 101, 73),
    scaffoldBackgroundColor: const Color.fromARGB(255, 196, 179, 138),
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
