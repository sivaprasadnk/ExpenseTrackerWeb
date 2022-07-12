// enum Mode { Cash, Online, All }

// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';

class TransactionModel {
  String title;
  String details;
  int amount;
  int categoryId;
  String categoryName;
  String transactionDate;
  String transactionDay;
  String transactionMonth;
  String transactionMonthDocId;
  String transactionType;
  String transactionDocId;
  String recentDocId;
  DateTime createdDateTime;

  String createdDateTimeString;
  TransactionModel({
    required this.title,
    required this.details,
    required this.amount,
    required this.categoryId,
    required this.categoryName,
    required this.transactionDate,
    required this.transactionDay,
    required this.transactionMonth,
    required this.transactionMonthDocId,
    required this.createdDateTimeString,
    required this.createdDateTime,
    required this.transactionType,
    required this.transactionDocId,
    required this.recentDocId,
  });

  static TransactionModel fromJson(QueryDocumentSnapshot<Object?> doc) {
    String transDate = doc['transactionDate'];
    var id = doc[kTransactionDocIdField];
    var recentDocId = doc[kRecentDocIdField];
    String expDay = transDate.split('-').first;
    return TransactionModel(
      amount: doc['amount'],
      createdDateTime: doc[kCreatedDateTimeField],
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
      transactionDate: transDate,
      transactionMonth: doc['transactionMonth'],
    );
  }

  static TransactionModel fromMap(Map doc) {
    String transDate = doc['transactionDate'];
    var id = doc['transactionDocId'];
    var recentDocId = doc['recentDocId'];
    String expDay = transDate.split('-').first;
    return TransactionModel(
      amount: doc['amount'],
      createdDateTime: doc[kCreatedDateTimeField],

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
      transactionDate: transDate,
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

  static Map<String, dynamic> toJson(TransactionModel trans) {
    return {
      'active': true,
      'amount': trans.amount,
      'amount_i': trans.amount.toString().toLowerCase(),
      'details': trans.details,
      'details_i': trans.details.toLowerCase(),
      'transactionType': trans.transactionType,
      'title': trans.title,
      'title_i': trans.title.toLowerCase(),
      'transactionMonth': trans.transactionMonth,
      'transactionMonthDocId': trans.transactionMonthDocId,
      'transactionDate': trans.transactionDate,
      'transactionDay': trans.transactionDay,
      'categoryId': trans.categoryId,
      'categoryName': trans.categoryName,
    };
  }
}
