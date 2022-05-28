import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/expense.list.item.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentExpensesListContainerMobile extends StatefulWidget {
  const RecentExpensesListContainerMobile({Key? key}) : super(key: key);

  @override
  _RecentExpensesListContainerMobileState createState() =>
      _RecentExpensesListContainerMobileState();
}

class _RecentExpensesListContainerMobileState
    extends State<RecentExpensesListContainerMobile> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  @override
  void initState() {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    stream = FirebaseFirestore.instance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kRecentExpensesCollection)
        .limit(5)
        .orderBy('createdDate', descending: true)
        .snapshots();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return SizedBox(
      height: screenHeight * 0.4,
      child: Consumer<HomeProvider>(
        builder: (_, provider, __) {
          return provider.recentExpensesList.isNotEmpty
              ? LiveList(
                  visibleFraction: 0.8,
                  showItemDuration: const Duration(milliseconds: 900),
                  padding: const EdgeInsets.only(left: 1, top: 10),
                  showItemInterval: const Duration(milliseconds: 50),
                  itemCount: provider.recentExpensesList.length,
                  itemBuilder: animationItemBuilder(
                    (index) {
                      var doc = provider.recentExpensesList[index];
                      RecentExpense recentExp = RecentExpense(
                          expenseTitle: doc.expenseTitle,
                          categoryId: doc.categoryId,
                          details: doc.details,
                          amount: doc.amount,
                          categoryName: doc.categoryName,
                          expenseDate: doc.expenseDate,
                          expenseMonth: doc.expenseMonth,
                          createdDate: doc.createdDate,
                          expenseDocId: doc.expenseDocId,
                          recentDocId: doc.recentDocId,
                          expenseDay: doc.expenseDay,
                          mode: doc.mode);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ExpenseListItem(
                          expense: recentExp,
                        ),
                      );
                    },
                  ),
                )
              : const NoExpenseContainerMobile(
                  title: 'Recently added expenses will list here.',
                );
        },
      ),
    );
  }

  Widget Function(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) animationItemBuilder(
    Widget Function(int index) child, {
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child(index),
              ),
            ),
          );
}
