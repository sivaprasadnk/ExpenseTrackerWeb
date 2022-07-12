import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionMonth {
  int year;
  String month;
  String monthOnly;
  String monthDocId;
  TransactionMonth({
    required this.year,
    required this.month,
    required this.monthOnly,
    required this.monthDocId,
  });

  static TransactionMonth fromDb(QueryDocumentSnapshot<Object?> doc) {
    return TransactionMonth(
      month: doc['month'],
      year: doc['year'],
      monthDocId: doc['monthDocId'],
      monthOnly: doc['monthOnly'],
    );
  }
}
