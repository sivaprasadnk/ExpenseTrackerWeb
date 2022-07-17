import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/transaction.model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  String monthlyDrOrCr_ = "+";
  String get monthlyDrOrCr => monthlyDrOrCr_;

  void updateMonthlyDrOrCr(String sign) {
    monthlyDrOrCr_ = sign;
    notifyListeners();
  }

  ///
  ///

  String dailyDrOrCr_ = "+";
  String get dailyDrOrCr => dailyDrOrCr_;

  void updateDailyOrCr(String sign) {
    dailyDrOrCr_ = sign;
    notifyListeners();
  }


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
    if (monthlyBalance_ < 0) {
      monthlyDrOrCr_ = "-";
      monthlyBalance_ *= -1;
    } else {
      monthlyDrOrCr_ = "+";
    }
    notifyListeners();
  }


  ///
  int dailyBalance_ = 0;
  int get dailyBalance => dailyBalance_;

  void updateDailyBalance() {
    dailyBalance_ = dailyTotalIncome - dailyTotalExpense;
    if (dailyBalance_ < 0) {
      dailyDrOrCr_ = "-";
      dailyBalance_ *= -1;
    } else {
      dailyDrOrCr_ = "+";
    }
    notifyListeners();
  }

  ///

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
    dailyTotalExpense_ = amt;
    notifyListeners();
  }

  void addToDailyTotalExpense(int amt) {
    dailyTotalExpense_ += amt;
    notifyListeners();
  }

  ///statistics
  ///
  ///  ///
  int dailyTotalExpenseStatistic_ = 0;
  int get dailyTotalExpenseStatistic => dailyTotalExpenseStatistic_;

  void updateStatisticDailyTotalExpense(int amt) {
    dailyTotalExpenseStatistic_ = amt;
    notifyListeners();
  }

  void addToStatisticDailyTotalExpense(int amt) {
    dailyTotalExpenseStatistic_ += amt;
    notifyListeners();
  }

  ///
  int dailyTotalIncomeStatistic_ = 0;
  int get dailyTotalIncomeStatistic => dailyTotalIncomeStatistic_;

  void updateStatisticDailyTotalIncome(int amt) {
    dailyTotalIncomeStatistic_ = amt;
    notifyListeners();
  }

  void addToStatisticDailyTotalIncome(int amt) {
    dailyTotalIncomeStatistic_ += amt;
    notifyListeners();
  }

  ///
  int monthlyTotalExpenseStatistic_ = 0;
  int get monthlyTotalExpenseStatistic => monthlyTotalExpenseStatistic_;

  void updateStatisticMonthlyTotalExpense(int amt) {
    monthlyTotalExpenseStatistic_ = amt;
    notifyListeners();
  }

  void addToStatisticMonthlyTotalExpense(int amt) {
    monthlyTotalExpenseStatistic_ += amt;
    notifyListeners();
  }

  ///
  int monthlyTotalIncomeStatistic_ = 0;
  int get monthlyTotalIncomeStatistic => monthlyTotalIncomeStatistic_;

  void updateStatisticMonthlyTotalIncome(int amt) {
    monthlyTotalIncomeStatistic_ = amt;
    notifyListeners();
  }

  void addToStatisticMonthlyTotalIncome(int amt) {
    monthlyTotalIncomeStatistic_ += amt;
    notifyListeners();
  }

  ///
  int dailyBalanceStatistic_ = 0;
  int get dailyBalanceStatistic => dailyBalanceStatistic_;

  void updateStatisticDailyBalance() {
    dailyBalanceStatistic_ =
        dailyTotalIncomeStatistic - dailyTotalExpenseStatistic;
    if (dailyBalanceStatistic_ < 0) {
      dailyDrOrCrStatistic_ = "-";
      dailyBalanceStatistic_ *= -1;
    } else {
      dailyDrOrCrStatistic_ = "+";
    }
    notifyListeners();
  }

  int monthlyBalanceStatistic_ = 0;
  int get monthlyBalanceStatistic => monthlyBalanceStatistic_;

  void updateStatisticMonthlyBalance() {
    monthlyBalanceStatistic_ =
        monthlyTotalIncomeStatistic - monthlyTotalExpenseStatistic;
    if (monthlyBalanceStatistic_ < 0) {
      monthlyDrOrCrStatistic_ = "-";
      monthlyBalanceStatistic_ *= -1;
    } else {
      monthlyDrOrCrStatistic_ = "+";
    }
    notifyListeners();
  }

  ///
  String dailyDrOrCrStatistic_ = "+";
  String get dailyDrOrCrStatistic => dailyDrOrCrStatistic_;

  void updateStatisticDailyOrCr(String sign) {
    dailyDrOrCrStatistic_ = sign;
    notifyListeners();
  }

  ///
  String monthlyDrOrCrStatistic_ = "+";
  String get monthlyDrOrCrStatistic => monthlyDrOrCrStatistic_;

  void updateStatisticMonthlyDrOrCr(String sign) {
    monthlyDrOrCrStatistic_ = sign;
    notifyListeners();
  }



}
