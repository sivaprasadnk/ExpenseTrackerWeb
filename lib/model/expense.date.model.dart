import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseDate {
  String date;
  String day;
  String month;
  String updatedTime;
  int totalExpense;
  // String expenseDate;
  ExpenseDate({
    required this.date,
    required this.day,
    required this.month,
    required this.updatedTime,
    required this.totalExpense,
  });

  static ExpenseDate fromJson(QueryDocumentSnapshot<Object?> doc) {
    return ExpenseDate(
      day: doc['day'],
      date: doc['date'],
      month: doc['month'],
      totalExpense: doc['totalExpense'],
      updatedTime: doc['updatedTime'],
    );
  }
}
