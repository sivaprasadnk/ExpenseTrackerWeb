import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.card.desktop.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenseByCategoryListDesktopScreen extends StatelessWidget {
  const ExpenseByCategoryListDesktopScreen(
      {Key? key, required this.categoryName})
      : super(key: key);
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    // final screenSize = MediaQuery.of(context).size;
    // final screenHeight = screenSize.height;
    // final ThemeNotifier theme =
    //     Provider.of<ThemeNotifier>(context, listen: true);
    // var primaryColor = theme.themeData.primaryColor;

    return DesktopView(
      appBarTitle: categoryName,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseCategoriesCollection)
            .doc(categoryName)
            .collection(kExpenseCollection)
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
                          expenseDay: "",
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
