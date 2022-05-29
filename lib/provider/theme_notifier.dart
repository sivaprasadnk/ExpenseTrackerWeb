import 'package:expense_tracker/provider/cache_notifier.dart';
import 'package:expense_tracker/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    _initiateTheme();
  }

  late ThemeData? _themeData = appThemeData[AppTheme.cream];
  ThemeData get themeData => _themeData!;

  final kThemePreference = 'kTheme';

  int _themeIndex = 0;
  int get themeIndex => _themeIndex;

  void _initiateTheme() {
    SharedPreferences.getInstance().then((prefs) {
      final int preferredTheme = prefs.getInt(kThemePreference) ?? 0;
      _themeData = appThemeData[AppTheme.values[preferredTheme]];
      _themeIndex = AppTheme.values[preferredTheme].index;
      notifyListeners();
    });
  }

  Future setTheme(AppTheme theme, int index, BuildContext ctx) async {
    _themeData = appThemeData[theme];
    _themeIndex = index;
    final CacheNotifier cacheNotifier =
        Provider.of<CacheNotifier>(ctx, listen: false);
    await cacheNotifier.writeCache(
        key: kThemePreference, value: _themeData.toString(), appTheme: theme);
    notifyListeners();
  }

  void toggleBrightness() {
    _themeData = ThemeData(
        scaffoldBackgroundColor: themeData.primaryColor,
        primaryColor: themeData.scaffoldBackgroundColor,
        drawerTheme: DrawerThemeData(backgroundColor: themeData.primaryColor),
        brightness: themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        appBarTheme: themeData.appBarTheme,
        pageTransitionsTheme: themeData.pageTransitionsTheme,
        splashColor: Colors.white,
        cardColor: themeData.cardColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Rajdhani',
            color: themeData.scaffoldBackgroundColor,
          ),
        ),
        secondaryHeaderColor: themeData.secondaryHeaderColor);
    notifyListeners();
  }
}
