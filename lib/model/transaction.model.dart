// enum Mode { Cash, Online, All }

import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  String title;
  String details;
  int categoryId;
  String categoryName;
  int amount;
  String transactionDate;
  String transactionDay;
  String transactionMonth;
  String transactionMonthDocId;
  String transactionDocId;
  String recentDocId;
  String createdDateTimeString;
  String transactionType;
  Transaction({
    required this.title,
    required this.categoryId,
    required this.details,
    required this.amount,
    required this.categoryName,
    required this.transactionDate,
    required this.transactionDay,
    required this.transactionMonth,
    required this.transactionMonthDocId,
    required this.createdDateTimeString,
    required this.transactionDocId,
    required this.recentDocId,
    required this.transactionType,
  });

  static Transaction fromJson(QueryDocumentSnapshot<Object?> doc) {
    String expDate = doc['expenseDate'];
    var id = doc['expenseDocId'];
    var recentDocId = doc['recentDocId'];
    String expDay = expDate.split('-').first;
    return Transaction(
      amount: doc['amount'],
      transactionType: doc['transactionType'],
      categoryId: doc['categoryId'],
      categoryName: doc['categoryName'],
      createdDateTimeString: doc['createdDateTimeString'],
      transactionDay: expDay,
      transactionDocId: id,
      recentDocId: recentDocId,
      transactionMonthDocId: "",
      title: doc['title'],
      details: doc['details'],
      transactionDate: doc['transactionDate'] ?? "",
      transactionMonth: doc['transactionMonth'],
    );
  }

  // static Transaction fromRecentTransaction(RecentExpense expense) {
  //   return Expense(
  //     expenseTitle: expense.expenseTitle,
  //     categoryId: expense.categoryId,
  //     details: expense.details,
  //     amount: expense.amount,
  //     recentDocId: expense.recentDocId,
  //     categoryName: expense.categoryName,
  //     expenseDate: expense.expenseDate,
  //     expenseDay: expense.expenseDay,
  //     expenseMonth: expense.expenseMonth,
  //     createdDateTimeString: expense.createdDateTimeString,
  //     expenseDocId: expense.expenseDocId,
  //     // expenseMonthDocId: expense.expenseMonthDocId,
  //     expenseMonthDocId: '',
  //     transactionType: expense.transactionType,
  //   );
  // }

  static Map<String, dynamic> toJson(Transaction trans) {
    return {
      'active': true,
      'amount': trans.amount,
      'amount_i': trans.amount.toString().toLowerCase(),
      'details': trans.details,
      'details_i': trans.details.toLowerCase(),
      'transactionType': trans.transactionType,
      'expenseTitle': trans.title,
      'expenseTitle_i': trans.title.toLowerCase(),
      'expenseMonth': trans.transactionMonth,
      'expenseMonthDocId': trans.transactionMonthDocId,
      'expenseDate': trans.transactionDate,
      'expenseDay': trans.transactionDay,
      'categoryId': trans.categoryId,
      'categoryName': trans.categoryName,
    };
  }
}
