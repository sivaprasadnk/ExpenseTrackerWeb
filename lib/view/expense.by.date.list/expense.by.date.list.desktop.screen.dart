import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.date.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.card.desktop.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenseByDateListScreen extends StatelessWidget {
  const ExpenseByDateListScreen({
    Key? key,
    required this.expenseDateItem,
  }) : super(key: key);
  final ExpenseDate expenseDateItem;
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return DesktopView(
      appBarTitle: expenseDateItem.date,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesNewCollection)
            .doc(expenseDateItem.date)
            .collection(kExpenseCollection)
            .orderBy('createdDate')
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData &&
                      (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (ctx, _) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                      itemBuilder: (ctx, index) {
                        var doc = (snapshot.data! as QuerySnapshot).docs[index];
                        Expense expense = Expense(
                          amount: doc['amount'],
                          mode: doc['mode'],
                          categoryIndex: doc['categoryId'],
                          categoryName: doc['categoryName'],
                          createdDate: doc['createdDate'],
                          expenseDay: doc['expenseDay'],
                          details: doc['details'],
                          expenseDocId: doc['expenseDocId'],
                          expenseTitle: doc['expenseTitle'],
                          expenseDate: doc['expenseDate'],
                          expenseMonth: doc['expenseMonth'],
                        );
                        return ExpenseDetailsCardDesktop(
                          expense: expense,
                          width: 450,
                        );
                      },
                    )
                  : const NoExpenseContainerDesktop(
                      title: 'No expense added !',
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
