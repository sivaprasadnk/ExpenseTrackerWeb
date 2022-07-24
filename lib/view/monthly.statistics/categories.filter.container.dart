import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/provider/statistics.provider.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesFilterContainer extends StatefulWidget {
  const CategoriesFilterContainer({Key? key}) : super(key: key);

  @override
  State<CategoriesFilterContainer> createState() =>
      _CategoriesFilterContainerState();
}

class _CategoriesFilterContainerState extends State<CategoriesFilterContainer> {
  @override
  Widget build(BuildContext context) {
    double btnWidth = 60;
    double btnHeight = 25;
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;

    return Consumer<StatisticsProvider>(
      builder: (_, provider, __) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  filterCategories(TransactionType.income);
                },
                child: Container(
                  height: btnHeight,
                  width: btnWidth,
                  decoration: BoxDecoration(
                    color: provider.selectedType == TransactionType.income
                        ? primaryColor
                        : bgColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Income',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: provider.selectedType == TransactionType.income
                            ? bgColor
                            : primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  filterCategories(TransactionType.expense);
                },
                child: Consumer<StatisticsProvider>(builder: (_, provider, __) {
                  return Container(
                    height: btnHeight,
                    width: btnWidth,
                    decoration: BoxDecoration(
                      color: provider.selectedType == TransactionType.expense
                          ? primaryColor
                          : bgColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Expense',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              provider.selectedType == TransactionType.expense
                                  ? bgColor
                                  : primaryColor,
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }

  void filterCategories(TransactionType type) {
    StatisticsProvider provider = context.read<StatisticsProvider>();
    List<TransactionCategoryModel>? categoryList = provider.categoryList;

    List<TransactionCategoryModel> tempList = [];

    for (int i = 0; i < categoryList!.length; i++) {
      if (categoryList[i].transactionType == type.name.initCap()) {
        tempList.add(categoryList[i]);
      }
    }

    tempList.sort(((a, b) => a.categoryId.compareTo(b.categoryId)));

    categoryList = tempList;
    provider.updateSelectedType(type);
    provider.updateFilteredCategoryList(categoryList);
    if (categoryList.isNotEmpty) {
      setStream(categoryList[0].categoryId);
    }
  }

  setStream(int categoryId) {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    StatisticsProvider provider = context.read<StatisticsProvider>();
    if (categoryId != -1) {
      var stream = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentTransactionCollection)
          .where('transactionMonthDocId',
              isEqualTo: provider.selectedMonthDocId)
          .where('transactionType',
              isEqualTo: provider.selectedType.name.initCap())
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('createdDateTime', descending: true)
          .snapshots();
      provider.updateStream(stream);
    } else {
      var stream = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentTransactionCollection)
          .where('transactionMonthDocId',
              isEqualTo: provider.selectedMonthDocId)
          .where('transactionType',
              isEqualTo: provider.selectedType.name.initCap())
          .orderBy('createdDateTime', descending: true)
          .snapshots();

      provider.updateStream(stream);
    }
  }
}
