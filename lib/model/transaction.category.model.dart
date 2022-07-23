import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionCategoryModel {
  int categoryId;
  String categoryName;
  int totalAmount;
  String transactionType;
  String lastUpdateTimeString;

  TransactionCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.totalAmount,
    required this.transactionType,
    required this.lastUpdateTimeString,
  });

  static TransactionCategoryModel fromDb(QueryDocumentSnapshot doc) {
    return TransactionCategoryModel(
      categoryId: doc['categoryId'],
      categoryName: doc['categoryName'],
      totalAmount: doc['totalAmount'],
      transactionType: doc['transactionType'],
      lastUpdateTimeString: doc['lastUpdateTimeString'],
    );
  }
}
