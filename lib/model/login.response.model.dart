import 'package:expense_tracker/api/response.status.dart';

class LoginResponse<T> {
  ResponseStatus status;
  String message;
  T data;
  String userId;
  // int dailyTotalIncome;
  // int dailyTotalExpense;
  // int dailyBalance;
  // int monthlyTotalIncome;
  // int monthlyTotalExpense;
  // int monthlyBalance;
  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.userId,
    // required this.dailyBalance,
    // required this.dailyTotalExpense,
    // required this.dailyTotalIncome,
    // required this.monthlyBalance,
    // required this.monthlyTotalExpense,
    // required this.monthlyTotalIncome,
  });
}
