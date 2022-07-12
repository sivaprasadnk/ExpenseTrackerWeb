import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';

class AddTransactionModel {
  TransactionModel transaction;
  int monthlyTotalExpense;
  int monthlyTotalIncome;
  String userId;
  String createdDateTimeString;
  DateTime createdDateTime;
  TransactionMonth transactionMonth;
  AddTransactionModel({
    required this.transaction,
    required this.monthlyTotalExpense,
    required this.userId,
    required this.createdDateTimeString,
    required this.transactionMonth,
    required this.createdDateTime,
    required this.monthlyTotalIncome,
  });
}
