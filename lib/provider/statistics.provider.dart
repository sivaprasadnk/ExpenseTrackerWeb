import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:flutter/cupertino.dart';

enum ViewType { monthly, daily }

class StatisticsProvider extends ChangeNotifier {
  ViewType selectedView_ = ViewType.monthly;
  ViewType get selectedView => selectedView_;

  void updateView(ViewType view) {
    selectedView_ = view;
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? stream_;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get stream => stream_;

  void updateStream(Stream<QuerySnapshot<Map<String, dynamic>>> stream1) {
    stream_ = stream1;
    notifyListeners();
  }

  List<TransactionCategoryModel>? categoryList_ = [];
  List<TransactionCategoryModel>? get categoryList => categoryList_;

  void updateCategoryList(List<TransactionCategoryModel> list) {
    categoryList_ = list;
    notifyListeners();
  }

  List<TransactionCategoryModel>? filteredCategoryList_ = [];
  List<TransactionCategoryModel>? get filteredCategoryList =>
      filteredCategoryList_;

  void updateFilteredCategoryList(List<TransactionCategoryModel> list) {
    filteredCategoryList_ = list;
    notifyListeners();
  }

  TransactionCategoryModel? selectedCategory_;
  TransactionCategoryModel? get selectedCategory => selectedCategory_;

  void updateSelectedCategory(TransactionCategoryModel model) {
    selectedCategory_ = model;
    notifyListeners();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? monthDocList_ = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get monthDocList =>
      monthDocList_;

  void updateMonthDocList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> monthList) {
    monthDocList_ = monthList;
    notifyListeners();
  }

  TransactionType selectedType_ = TransactionType.income;
  TransactionType get selectedType => selectedType_;

  void updateSelectedType(TransactionType type) {
    selectedType_ = type;
    notifyListeners();
  }

  int touchedIndex_ = 0;
  int get touchedIndex => touchedIndex_;

  void updateTouchedIndex(int index) {
    touchedIndex_ = index;
    notifyListeners();
  }

  TransactionMonth? transacationMonth_;
  TransactionMonth? get transacationMonth => transacationMonth_;

  void updateMonth(TransactionMonth month) {
    transacationMonth_ = month;
    notifyListeners();
  }

  String selectedMonthDocId_ = "";
  String get selectedMonthDocId => selectedMonthDocId_;

  void updateSelectedMonthDocId(String id) {
    selectedMonthDocId_ = id;
    notifyListeners();
  }
}
