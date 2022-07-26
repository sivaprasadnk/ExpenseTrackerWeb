import 'package:expense_tracker/model/daily.balance.model.dart';
import 'package:expense_tracker/model/total.balance.model.dart';
import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';

class AddTransactionModel {
  String userId;
  TransactionModel transaction;
  DailyBalanceModel dailyBalanceModel;
  TotalBalanceModel totalBalanceModel;
  TransactionMonth transactionMonth;
  DateTime currentDateTime;
  String currentDateTimeString;
  AddTransactionModel({
    required this.transaction,
    required this.dailyBalanceModel,
    required this.totalBalanceModel,
    required this.userId,
    required this.currentDateTimeString,
    required this.transactionMonth,
    required this.currentDateTime,
  });
}
