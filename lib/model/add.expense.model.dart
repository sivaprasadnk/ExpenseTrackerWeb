import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/expense.month.model.dart';

class AddExpenseModel {
  Expense expense;
  int dailyTotal;
  int dailyCashTotal;
  int dailyOnlineTotal;
  String userId;
  String createdDateTimeString;
  DateTime createdDateTime;
  ExpenseMonth expenseMonth;
  AddExpenseModel({
    required this.expense,
    required this.dailyTotal,
    required this.userId,
    required this.createdDateTimeString,
    required this.expenseMonth,
    required this.createdDateTime,
    required this.dailyCashTotal,
    required this.dailyOnlineTotal,
  });
}

class AddExpenseModelV2 {
  Expense expense;
  int monthlyTotalExpense;
  int monthlyTotalIncome;
  // int dailyOnlineTotal;
  String userId;
  String createdDateTimeString;
  DateTime createdDateTime;
  ExpenseMonth expenseMonth;
  AddExpenseModelV2({
    required this.expense,
    required this.monthlyTotalExpense,
    required this.userId,
    required this.createdDateTimeString,
    required this.expenseMonth,
    required this.createdDateTime,
    required this.monthlyTotalIncome,
    // required this.dailyOnlineTotal,
  });
}
