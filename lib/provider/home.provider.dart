import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/transaction.model.dart';
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

  List<TransactionModel> recentTransactionsList_ = [];
  List<TransactionModel> get recentTransactionsList => recentTransactionsList_;

  void updateRecentList(List<TransactionModel> list) {
    recentTransactionsList_ = list;
    notifyListeners();
  }

  void addToRecentList(TransactionModel expense) {
    recentTransactionsList_.add(expense);
    recentTransactionsList_
        .sort((a, b) => b.createdDateTime.compareTo(a.createdDateTime));
    notifyListeners();
  }

  ///

  // int monthlyTotal = 0;
  // int get monthlyTotalExpense => monthlyTotal;

  // void updateMonthlyTotal(int amt) {
  //   monthlyTotal = amt;
  //   notifyListeners();
  // }

  // void addToMonthlyTotal(int amt) {
  //   monthlyTotal += amt;
  //   notifyListeners();
  // }

  // void deductFromMonthlyTotal(int amt) {
  //   monthlyTotal -= amt;
  //   notifyListeners();
  // }

  ///

  int monthlyBalance_ = 0;
  int get monthlyBalance => monthlyBalance_;

  void updateMonthlyBalance() {
    monthlyBalance_ = monthlyTotalIncome - monthlyTotalExpense;
    notifyListeners();
  }

  ///
  int dailyBalance_ = 0;
  int get dailyBalance => dailyBalance_;

  void updateDailyBalance() {
    dailyBalance_ = dailyTotalIncome - dailyTotalExpense;
    notifyListeners();
  }

  ///
  int monthlyTotalIncome_ = 0;
  int get monthlyTotalIncome => monthlyTotalIncome_;

  void updateMonthlyTotalIncome(int amt) {
    monthlyTotalIncome_ = amt;
    notifyListeners();
  }

  void addToMonthlyTotalIncome(int amt) {
    monthlyTotalIncome_ += amt;
    notifyListeners();
  }

  ///
  int monthlyTotalExpense_ = 0;
  int get monthlyTotalExpense => monthlyTotalExpense_;

  void updateMonthlyTotalExpense(int amt) {
    monthlyTotalExpense_ = amt;
    notifyListeners();
  }

  void addToMonthlyTotalExpense(int amt) {
    monthlyTotalExpense_ += amt;
    notifyListeners();
  }

  ///
  int dailyTotalIncome_ = 0;
  int get dailyTotalIncome => dailyTotalIncome_;

  void updateDailyTotalIncome(int amt) {
    dailyTotalIncome_ = amt;
    notifyListeners();
  }

  void addToDailyTotalIncome(int amt) {
    dailyTotalIncome_ += amt;
    notifyListeners();
  }

  ///
  int dailyTotalExpense_ = 0;
  int get dailyTotalExpense => dailyTotalExpense_;

  void updateDailyTotalExpense(int amt) {
    monthlyTotalExpense_ = amt;
    notifyListeners();
  }

  void addToDailyTotalExpense(int amt) {
    monthlyTotalExpense_ += amt;
    notifyListeners();
  }

  ///
  // int dailyTotal_ = 0;
  // int dailyCashTotal_ = 0;
  // int dailyOnlineTotal_ = 0;

  // int get dailyTotalExpense => dailyTotal_;
  // int get dailyCashTotal => dailyCashTotal_;
  // int get dailyOnlineTotal => dailyOnlineTotal_;

  // void updateDailyTotalExpense(int total) {
  //   dailyTotal_ = total;
  //   notifyListeners();
  // }

  // void updateDailyCashTotalExpense(int total) {
  //   dailyCashTotal_ = total;
  //   notifyListeners();
  // }

  // void updateDailyOnlineTotalExpense(int total) {
  //   dailyOnlineTotal_ = total;
  //   notifyListeners();
  // }

  // void addToDailyExpense(int amt) {
  //   dailyTotal_ += amt;
  //   notifyListeners();
  // }

  // void addToDailyCashExpense(int amt) {
  //   dailyCashTotal_ += amt;
  //   notifyListeners();
  // }

  // void addToDailyOnlineExpense(int amt) {
  //   dailyOnlineTotal_ += amt;
  //   notifyListeners();
  // }

  // void deductFromdailyExpense(int amt) {
  //   dailyTotal_ -= amt;
  //   notifyListeners();
  // }
}
