import 'package:cloud_firestore/cloud_firestore.dart';

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
      month: doc['month'],
      year: doc['year'],
      monthDocId: doc['monthDocId'],
      monthOnly: doc['monthOnly'],
      monthlyTotalIncome: doc['monthlyTotalIncome'],
      monthlyBalance: doc['monthlyBalance'],
      monthlyDrOrCr: doc['monthlyDrOrCr'],
      monthlyTotalExpense: doc['monthlyTotalExpense'],
      updatedDateTimeString: doc['updatedDateTimeString'],
    );
  }

  static Map<String, dynamic> toJson(TransactionMonth model) {
    return {
      'month': model.month,
      'year': model.year,
      'monthDocId': model.monthDocId,
      'monthOnly': model.monthOnly,
      'monthlyTotalIncome': model.monthlyTotalIncome,
      'monthlyTotalExpense': model.monthlyTotalExpense,
      'monthlyBalance': model.monthlyBalance,
      'monthlyDrOrCr': model.monthlyDrOrCr,
      'updatedDateTimeString': model.updatedDateTimeString,
    };
  }
}
