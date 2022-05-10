import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.date.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/windows/small/expense.by.date.list/expense.amount.text.dart';
import 'package:expense_tracker/view/windows/small/expense.by.date.list/expense.title.text.dart';
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
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kExpenseDatesNewCollection)
              .doc(expenseDateItem.day)
              .collection(kExpenseCollection)
              .orderBy('createdDate')
              // .doc(month)
              // .collection(date)
              // .doc(date)
              // .collection(kExpenseCollection)
              .snapshots(),
          builder: (_, snapshot) {
            return snapshot.connectionState != ConnectionState.done
                ? snapshot.hasData &&
                        (snapshot.data! as QuerySnapshot).docs.length > 0
                    ? GridView.builder(
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (ctx, index) {
                          var doc =
                              (snapshot.data! as QuerySnapshot).docs[index];
                          Expense expense = Expense(
                            amount: doc['amount'],
                            categoryIndex: doc['categoryId'],
                            categoryName: doc['categoryName'],
                            createdDate: doc['createdDate'],
                            details: doc['details'],
                            expenseDocId: doc['expenseDocId'],
                            expenseTitle: doc['expenseTitle'],
                            expenseDate: doc['expenseDate'],
                            expenseMonth: doc['expenseMonth'],
                          );
                          return Container(
                            height: 50,
                            decoration: BoxDecoration(
                              // color: Colors.cyan,
                              border: Border.all(
                                color: Colors.cyan,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ExpenseAmountText(
                                  amount: expense.amount.toString(),
                                ),
                                ExpenseTitleText(
                                  title: expense.expenseTitle,
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: screenHeight * 0.5,
                        child: const Center(
                          child: Text(
                            'No Data !',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
