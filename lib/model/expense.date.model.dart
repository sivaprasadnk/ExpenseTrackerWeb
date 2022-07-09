import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseDate {
  String date;
  String day;
  String month;
  String updatedDateTime;
  String cashTotal;
  String onlineTotal;
  int totalExpense;
  // String expenseDate;
  ExpenseDate({
    required this.date,
    required this.day,
    required this.month,
    required this.updatedDateTime,
    required this.totalExpense,
    required this.cashTotal,
    required this.onlineTotal,
  });

  static ExpenseDate fromJson(QueryDocumentSnapshot<Object?> doc) {
    return ExpenseDate(
      day: doc['day'],
      date: doc['date'],
      month: doc['month'],
      totalExpense: doc['totalExpense'],
      updatedDateTime: '',
      cashTotal: doc['totalCashExpense'].toString(),
      onlineTotal: doc['totalOnlineExpense'].toString(),
    );
  }
}
