import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.card.mobile.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenseByCategoryListMobileScreen extends StatelessWidget {
  const ExpenseByCategoryListMobileScreen(
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

    return MobileView(
      appBarTitle: categoryName,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseCategoriesCollection)
            .doc(categoryName)
            .collection(kExpenseCollection)
            .orderBy('createdDateTimeString', descending: true)
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData &&
                      (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.separated(
                        separatorBuilder: (ctx, _) => const SizedBox(
                          height: 10,
                        ),
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        itemBuilder: (ctx, index) {
                          var doc =
                              (snapshot.data! as QuerySnapshot).docs[index];
                          Expense expense = Expense.fromJson(doc);
                          return ExpenseDetailsCardMobile(
                            expense: expense,
                            // width: double.infinity,
                          );
                        },
                      ),
                    )
                  : const NoExpenseContainerMobile(
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
