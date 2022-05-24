import 'package:cloud_firestore/cloud_firestore.dart';

class RecentExpense {
  String expenseTitle;
  String details;
  int categoryId;
  String categoryName;
  int amount;
  String expenseDate;
  String expenseDay;
  String expenseMonth;
  String createdDate;
  String recentDocId;
  String expenseDocId;
  String mode;
  RecentExpense(
      {required this.expenseTitle,
      required this.categoryId,
      required this.details,
      required this.amount,
      required this.categoryName,
      required this.expenseDate,
      required this.expenseMonth,
      required this.createdDate,
      required this.recentDocId,
      required this.expenseDocId,
      required this.expenseDay,
      required this.mode});

  factory RecentExpense.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return RecentExpense(
      expenseTitle: data['expenseTitle'],
      categoryId: data['categoryId'],
      details: data['details'],
      amount: data['amount'],
      categoryName: data['categoryName'],
      expenseDate: data['expenseDate'],
      expenseMonth: data['expenseMonth'],
      createdDate: data['createdDate'],
      recentDocId: data['recentDocId'],
      expenseDocId: data['expenseDocId'],
      expenseDay: data['expenseDay'],
      mode: data['mode'],
    );
  }
}
