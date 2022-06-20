import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.details.card.desktop.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysExpenseListDesktopScreen extends StatelessWidget {
  const TodaysExpenseListDesktopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    var date = DateFormat('dd-MM-yyyy').format(now);
    var month = DateFormat('MMM, yyyy').format(now);

    var day = date.split('-').first;
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return DesktopView(
      isHome: false,
      appBarTitle: day + " $month",
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesNewCollection)
            .doc(date)
            .collection(kExpenseCollection)
            .orderBy('createdDateTimeString')
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
                        Expense expense = Expense.fromJson(doc);
                        return Center(
                          child: SizedBox(
                            width: 450,
                            child: ExpenseDetailsCardDesktop(
                              expense: expense,
                              width: 450,
                            ),
                          ),
                        );
                      },
                    )
                  : const NoExpenseContainerDesktop(
                      showAddButton: true,
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
