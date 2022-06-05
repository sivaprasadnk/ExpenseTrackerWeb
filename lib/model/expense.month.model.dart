import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseMonth {
  int year;
  String month;
  String monthOnly;
  String monthDocId;
  ExpenseMonth({
    required this.year,
    required this.month,
    required this.monthOnly,
    required this.monthDocId,
  });

  static ExpenseMonth fromDb(QueryDocumentSnapshot<Object?> doc) {
    return ExpenseMonth(
      // date: doc['date'],
      month: doc['month'],
      year: doc['year'],
      monthDocId: doc['monthDocId'],
      monthOnly: doc['monthOnly'],
    );
  }
}
