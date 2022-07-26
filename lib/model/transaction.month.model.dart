import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';

class TransactionMonth {
  int year;
  String month;
  String monthOnly;
  String monthDocId;
  int monthlyBalance;
  int monthlyTotalExpense;
  int monthlyTotalIncome;
  String monthlyDrOrCr;
  String updatedDateTimeString;
  TransactionMonth({
    required this.year,
    required this.month,
    required this.monthOnly,
    required this.monthDocId,
      required this.monthlyBalance,
      required this.monthlyDrOrCr,
      required this.monthlyTotalExpense,
      required this.monthlyTotalIncome,
      this.updatedDateTimeString = ""
  });

  static TransactionMonth fromDb(QueryDocumentSnapshot<Object?> doc) {
    return TransactionMonth(
      month: doc[kMonthField],
      year: doc[kYearField],
      monthDocId: doc[kMonthDocIdField],
      monthOnly: doc[kMonthOnlyField],
      monthlyTotalIncome: doc[kMonthlyTotalIncomeField],
      monthlyTotalExpense: doc[kMonthlyTotalExpenseField],
      monthlyBalance: doc[kMonthlyBalanceField],
      monthlyDrOrCr: doc[kMonthlyDrOrCrField],
      updatedDateTimeString: doc[kLastUpdateTimeStringField],
    );
  }

  static Map<String, dynamic> toJson(TransactionMonth model) {
    return {
      kMonthField: model.month,
      kYearField: model.year,
      kMonthDocIdField: model.monthDocId,
      kMonthOnlyField: model.monthOnly,
      kMonthlyTotalIncomeField: model.monthlyTotalIncome,
      kMonthlyTotalExpenseField: model.monthlyTotalExpense,
      kMonthlyBalanceField: model.monthlyBalance,
      kMonthlyDrOrCrField: model.monthlyDrOrCr,
      kLastUpdateTimeStringField: model.updatedDateTimeString,
    };
  }
}
