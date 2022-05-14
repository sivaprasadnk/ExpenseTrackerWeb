import 'package:expense_tracker/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheNotifier extends ChangeNotifier {
  Future writeCache({
    required String key,
    required String value,
    required AppTheme appTheme,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, AppTheme.values.indexOf(appTheme));
  }
}
