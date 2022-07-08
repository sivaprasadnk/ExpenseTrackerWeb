import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  String currencySymbol_ = kRupeeSymbol;
  String get currencySymbol => currencySymbol_;

  String currency_ = "";
  String get currency => currency_;

  void updateCurrency(String currency) {
    currency_ = currency;
    if (currency == "INR") {
      currencySymbol_ = kRupeeSymbol;
      // currencySymbol_ = "د.إ";
    } else if (currency == "USD") {
      currencySymbol_ = '\$';
    } else if (currency == "AED") {
      currencySymbol_ = "د.إ";
    } else {
      currencySymbol_ = '\$';
    }
    notifyListeners();
  }

  List<RecentExpense> recentExpensesList_ = [];
  List<RecentExpense> get recentExpensesList => recentExpensesList_;

  void updateRecentList(List<RecentExpense> list) {
    recentExpensesList_ = list;
    notifyListeners();
  }

  void addToRecentList(RecentExpense expense) {
    recentExpensesList_.add(expense);
    recentExpensesList_.sort((a, b) => b.createdDate.compareTo(a.createdDate));
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
  int dailyCashTotal_ = 0;
  int dailyOnlineTotal_ = 0;

  int get dailyTotalExpense => dailyTotal_;
  int get dailyCashTotal => dailyCashTotal_;
  int get dailyOnlineTotal => dailyOnlineTotal_;

  void updateDailyTotalExpense(int total) {
    dailyTotal_ = total;
    notifyListeners();
  }

  void updateDailyCashTotalExpense(int total) {
    dailyCashTotal_ = total;
    notifyListeners();
  }
  
  void updateDailyOnlineTotalExpense(int total) {
    dailyOnlineTotal_ = total;
    notifyListeners();
  }

  void addToDailyExpense(int amt) {
    dailyTotal_ += amt;
    notifyListeners();
  }

    void addToDailyCashExpense(int amt) {
    dailyCashTotal_ += amt;
    notifyListeners();
  }


    void addToDailyOnlineExpense(int amt) {
    dailyOnlineTotal_ += amt;
    notifyListeners();
  }


  void deductFromdailyExpense(int amt) {
    dailyTotal_ -= amt;
    notifyListeners();
  }
}
