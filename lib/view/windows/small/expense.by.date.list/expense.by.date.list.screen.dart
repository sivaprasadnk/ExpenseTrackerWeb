import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.date.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/expense.list.item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
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
                    ? ListView.separated(
                        separatorBuilder: (ctx, _) => SizedBox(
                          height: 10,
                        ),
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 3,
                        //   mainAxisSpacing: 20,
                        //   crossAxisSpacing: 20,
                        // ),
                        itemBuilder: (ctx, index) {
                          var doc =
                              (snapshot.data! as QuerySnapshot).docs[index];
                          Expense expense = Expense(
                            amount: doc['amount'],
                            mode: "",
                            categoryIndex: doc['categoryId'],
                            categoryName: doc['categoryName'],
                            createdDate: doc['createdDate'],
                            details: doc['details'],
                            expenseDocId: doc['expenseDocId'],
                            expenseTitle: doc['expenseTitle'],
                            expenseDate: doc['expenseDate'],
                            expenseMonth: doc['expenseMonth'],
                          );
                          return ExpenseListItemContainer(
                            amount: expense.amount.toString(),
                            subTitle: expense.categoryName,
                            title: expense.expenseTitle,
                          );
                        },
                      )
                    : SizedBox(
                        height: screenHeight * 0.5,
                        child: const Center(
                          child: Text(
                            'No Data !',
                            style: TextStyle(
                                // color: Colors.white,
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
