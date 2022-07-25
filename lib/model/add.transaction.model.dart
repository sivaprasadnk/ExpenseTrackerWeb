import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';

class AddTransactionModel {
  TransactionModel transaction;
  int dailyTotalExpense;
  int dailyTotalIncome;
  String userId;
  String dailyDrOrCr;
  String currentDateTimeString;
  DateTime currentDateTime;
  TransactionMonth transactionMonth;
  AddTransactionModel({
    required this.transaction,
    required this.dailyTotalIncome,
    required this.dailyTotalExpense,
    required this.userId,
    required this.currentDateTimeString,
    required this.transactionMonth,
    required this.currentDateTime,
    required this.dailyDrOrCr,
  });
}
