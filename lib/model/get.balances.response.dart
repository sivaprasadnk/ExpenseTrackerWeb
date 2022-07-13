import 'package:expense_tracker/api/response.status.dart';

class GetBalancesResponse {
  ResponseStatus status;
  String message;
  String data;
  String userId;
  int monthlyTotalIncome;
  int monthlyTotalExpense;
  String monthlyDrOrCr;
  int monthlyBalance;
  int dailyTotalIncome;
  int dailyTotalExpense;
  int dailyBalance;
  String dailyDrOrCr;
  GetBalancesResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.monthlyBalance,
    required this.monthlyDrOrCr,
    required this.monthlyTotalIncome,
    required this.dailyBalance,
    required this.dailyDrOrCr,
    required this.dailyTotalExpense,
    required this.dailyTotalIncome,
    required this.monthlyTotalExpense,
    required this.userId,
    // this.userId = "",
  });
}
