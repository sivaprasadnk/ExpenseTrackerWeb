import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/expense.month.model.dart';

class AddExpenseModel {
  Expense expense;
  int dailyTotal;
  int dailyCashTotal;
  int dailyOnlineTotal;
  String userId;
  String currentDateTimeString;
  DateTime currentDateTime;
  ExpenseMonth expenseMonth;
  AddExpenseModel({
    required this.expense,
    required this.dailyTotal,
    required this.userId,
    required this.currentDateTimeString,
    required this.expenseMonth,
    required this.currentDateTime,
    required this.dailyCashTotal,
    required this.dailyOnlineTotal,
  });
}
