import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/transaction.model.dart';

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
  List<TransactionModel> recentExpList;
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
    required this.recentExpList,
    // this.userId = "",
  });
}
