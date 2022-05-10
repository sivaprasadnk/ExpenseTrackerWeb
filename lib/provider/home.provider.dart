import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List<RecentExpense> recentExpensesList_ = [];
  List<RecentExpense> get recentExpensesList => recentExpensesList_;

  void updateRecentList(List<RecentExpense> list) {
    recentExpensesList_ = list;
    notifyListeners();
  }

  ///

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

  void deductFromMonthlyTotal(int amt) {
    monthlyTotal -= amt;
    notifyListeners();
  }

  ///
  int dailyTotal_ = 0;

  int get dailyTotalExpense => dailyTotal_;

  void updateDailyTotalExpense(int total) {
    dailyTotal_ = total;
    notifyListeners();
  }

  void addToDailyExpense(int amt) {
    dailyTotal_ += amt;
    debugPrint('daily total :');
    debugPrint(dailyTotal_.toString());
    notifyListeners();
  }

  void deductFromdailyExpense(int amt) {
    dailyTotal_ -= amt;
    notifyListeners();
  }
}
