import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  int monthlyTotal = 0;
  int get monthlyTotalExpense => monthlyTotal;

  void updateMonthlyTotal(int amt) {
    monthlyTotal = amt;
    notifyListeners();
  }

  void addToMonthlyTotal(int amt) {
    monthlyTotal += amt;
    notifyListeners();
  }

  ///
  int dailyTotal = 0;

  int get dailyTotalExpense => dailyTotal;

  void updateDailyTotalExpense(int total) {
    dailyTotal = total;
    notifyListeners();
  }

  void addToDailyExpense(int amt) {
    dailyTotal += amt;
    debugPrint('.. @@ dailyTotal : $dailyTotal');
    notifyListeners();
  }
}
