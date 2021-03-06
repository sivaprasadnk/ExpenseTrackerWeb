import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.mobile/expense.details.card.mobile.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysExpenseListMobileScreen extends StatelessWidget {
  const TodaysExpenseListMobileScreen({Key? key}) : super(key: key);
  static const routeName = '/TodaysExpenseList';

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    var date = DateFormat('dd-MM-yyyy').format(now);

    var month = DateFormat('MMM, yyyy').format(now);
    var day = date.split('-').first;
    var userId = FirebaseAuth.instance.currentUser!.uid;

    return MobileView(
      appBarTitle: '$day $month',
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

                        return ExpenseDetailsCardMobile(
                          expense: expense,
                          width: 450,
                        );
                      },
                    )
                  : const NoExpenseContainerMobile(
                      title: 'No Expenses added today !',
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
