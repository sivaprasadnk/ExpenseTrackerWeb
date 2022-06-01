// enum Mode { Cash, Online, All }

import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String expenseTitle;
  String details;
  int categoryId;
  String categoryName;
  int amount;
  String expenseDate;
  String expenseDay;
  String expenseMonth;
  String expenseDocId;
  String createdDate;
  String mode;
  Expense({
    required this.expenseTitle,
    required this.categoryId,
    required this.details,
    required this.amount,
    required this.categoryName,
    required this.expenseDate,
    required this.expenseDay,
    required this.expenseMonth,
    required this.createdDate,
    required this.expenseDocId,
    required this.mode,
  });

  static Expense fromJson(QueryDocumentSnapshot<Object?> doc) {
    return Expense(
      amount: doc['amount'],
      mode: doc['mode'],
      categoryId: doc['categoryId'],
      categoryName: doc['categoryName'],
      createdDate: doc['createdDate'],
      // expenseDay: doc['expenseDay'] ?? "",
      expenseDay: "",
      details: doc['details'],
      expenseDocId: doc['expenseDocId'] ?? "",
      expenseTitle: doc['expenseTitle'],
      expenseDate: doc['expenseDate'] ?? "",
      expenseMonth: doc['expenseMonth'],
    );
  }
}
