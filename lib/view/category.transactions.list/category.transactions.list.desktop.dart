import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../monthly.statistics/transaction.item.dart';

class CategoryTransactionsListDesktop extends StatefulWidget {
  const CategoryTransactionsListDesktop({
    Key? key,
    required this.category,
    required this.type,
  }) : super(key: key);

  final TransactionCategoryModel category;
  final TransactionType type;

  @override
  State<CategoryTransactionsListDesktop> createState() =>
      _CategoryTransactionsListDesktopState();
}

class _CategoryTransactionsListDesktopState
    extends State<CategoryTransactionsListDesktop> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var height = MediaQuery.of(context).size.height;

    return DesktopView(
      isHome: false,
      appBarTitle: widget.category.categoryName,
      child: Center(
        child: Container(
          width: 430,
          height: MediaQuery.of(context).size.height * 0.9,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  // height: height * 0.8,
                  width: 430,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      width: 1,
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text(
                                  '$currency ${widget.category.totalAmount}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10)
                          ],
                        ),
                        const SizedBox(height: 25),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(kUsersCollection)
                              .doc(userId)
                              .collection(kRecentTransactionCollection)
                              .where('categoryName',
                                  isEqualTo: widget.category.categoryName)
                              .where('transactionType',
                                  isEqualTo: widget.type.name.initCap())
                              .orderBy('createdDateTime', descending: true)
                              .snapshots(),
                          builder: (_, snapshot) {
                            return snapshot.hasData
                                ? (snapshot.data! as QuerySnapshot)
                                        .docs
                                        .isNotEmpty
                                    ? SizedBox(
                                        height: height * 0.7,
                                        child: ListView.separated(
                                          // scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              (snapshot.data! as QuerySnapshot)
                                                  .docs
                                                  .length,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(height: 10),
                                          itemBuilder: (_, index) {
                                            var doc = (snapshot.data!
                                                    as QuerySnapshot)
                                                .docs[index];
                                            TransactionModel trans =
                                                TransactionModel.fromJson(doc);
                                            return TransactionListItem(
                                              trans: trans,
                                              showCategory: false,
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox(
                                        child: Text(
                                          'No data found !!',
                                          style: TextStyle(color: bgColor),
                                        ),
                                      )
                                : SizedBox(
                                    child: Text(
                                      'No data found !',
                                      style: TextStyle(color: bgColor),
                                    ),
                                  );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
