import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/transaction.model.dart';

class GetBalancesResponse {
  ResponseStatus status;
  String message;
  String data;
  String userId;
  int totalIncome;
  int totalExpense;
  int totalBalance;
  String drOrCr;
  List<TransactionModel> recentExpList;
  GetBalancesResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.userId,
    required this.recentExpList,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalBalance,
    required this.drOrCr,
    // this.userId = "",
  });
}
