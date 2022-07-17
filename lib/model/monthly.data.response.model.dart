import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';

class MonthlyDataResponseModel {
  TransactionMonth? transactionMonth;
  List<TransactionCategoryModel>? categoryList;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> monthDocList;
  MonthlyDataResponseModel({
    required this.transactionMonth,
    this.categoryList,
    required this.monthDocList,
  });
}
