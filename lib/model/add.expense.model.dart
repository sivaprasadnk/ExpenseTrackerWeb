import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/model/expense.month.model.dart';

class AddExpenseModel {
  Expense expense;
  int dailyTotal;
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
  });
}
