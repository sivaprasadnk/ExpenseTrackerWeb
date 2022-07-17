import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionCategoryModel {
  int categoryId;
  String categoryName;
  int totalAmount;
  String transactionType;

  TransactionCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.totalAmount,
    required this.transactionType,
  });

  static TransactionCategoryModel fromDb(QueryDocumentSnapshot doc) {
    return TransactionCategoryModel(
      categoryId: doc['categoryId'],
      categoryName: doc['categoryName'],
      totalAmount: doc['totalAmount'],
      transactionType: doc['transactionType'],
    );
  }
}
