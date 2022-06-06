// enum Mode { Cash, Online, All }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';

class Expense {
  String expenseTitle;
  String details;
  int categoryId;
  String categoryName;
  int amount;
  String expenseDate;
  String expenseDay;
  String expenseMonth;
  String expenseMonthDocId;
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
    required this.expenseMonthDocId,
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
      createdDate: doc['createdDateTimeString'],
      // expenseDay: doc['expenseDay'] ?? "",
      expenseDay: doc['expenseDay'],
      details: doc['details'],
      expenseDocId: doc['expenseDocId'] ?? "",
      expenseMonthDocId: "",
      expenseTitle: doc['expenseTitle'],
      expenseDate: doc['expenseDate'] ?? "",
      expenseMonth: doc['expenseMonth'],
    );
  }

  static Expense fromRecentExpense(RecentExpense expense) {
    return Expense(
      expenseTitle: expense.expenseTitle,
      categoryId: expense.categoryId,
      details: expense.details,
      amount: expense.amount,
      categoryName: expense.categoryName,
      expenseDate: expense.expenseDate,
      expenseDay: expense.expenseDay,
      expenseMonth: expense.expenseMonth,
      createdDate: expense.createdDateTimeString,
      expenseDocId: expense.expenseDocId,
      // expenseMonthDocId: expense.expenseMonthDocId,
      expenseMonthDocId: '',
      mode: expense.mode,
    );
  }

  static Map<String, dynamic> toJson(Expense expense) {
    return {
      'active': true,
      'amount': expense.amount,
      'amount_i': expense.amount.toString().toLowerCase(),
      'details': expense.details,
      'details_i': expense.details.toLowerCase(),
      'mode': expense.mode,
      'expenseTitle': expense.expenseTitle,
      'expenseTitle_i': expense.expenseTitle.toLowerCase(),
      'expenseMonth': expense.expenseMonth,
      'expenseMonthDocId': expense.expenseMonthDocId,
      'expenseDate': expense.expenseDate,
      'expenseDay': expense.expenseDay,
      'categoryId': expense.categoryId,
      'categoryName': expense.categoryName,
      // 'createdDateTime': request.createdDateTime,
      // 'createdDateTimeString': request.createdDateTimeString,
      // 'expenseDocId': '',
    };
  }
}
