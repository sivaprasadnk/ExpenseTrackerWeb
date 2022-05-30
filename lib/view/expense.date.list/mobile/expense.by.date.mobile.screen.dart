import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.date.model.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/expense.by.date.list/expense.by.date.list.mobile.screen.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.amount.text.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.date.text.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.month.text.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';
import 'package:provider/provider.dart';

class ExpenseByDateMobileScreen extends StatefulWidget {
  const ExpenseByDateMobileScreen({Key? key}) : super(key: key);

  @override
  _ExpenseByDateMobileScreenState createState() =>
      _ExpenseByDateMobileScreenState();
}

class _ExpenseByDateMobileScreenState extends State<ExpenseByDateMobileScreen> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;

    return MobileView(
      appBarTitle: 'Select Date',
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesNewCollection)
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData &&
                      (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? Center(
                      child: SizedBox(
                        width: 450,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:
                              (snapshot.data! as QuerySnapshot).docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 90,
                          ),
                          itemBuilder: (ctx, index) {
                            var doc =
                                (snapshot.data! as QuerySnapshot).docs[index];
                            var expDate = ExpenseDate(
                              day: doc['day'],
                              date: doc['date'],
                              month: doc['month'],
                              totalExpense: doc['totalExpense'],
                              updatedTime: doc['updatedTime'],
                            );
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            ExpenseByDateListMobileScreen(
                                              expenseDateItem: expDate,
                                            )));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    width: 130,
                                    height: 150,
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          ExpenseDateText(
                                            date: expDate.day,
                                            fontColor: theme.themeData.textTheme
                                                .bodyMedium!.color!,
                                          ),
                                          ExpenseMonthText(
                                            month: expDate.month,
                                            textColor: theme.themeData.textTheme
                                                .bodyMedium!.color!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ExpenseAmountText(
                                    borderColor: theme.themeData.primaryColor,
                                    fillColor:
                                        theme.themeData.scaffoldBackgroundColor,
                                    amount: expDate.totalExpense.toString(),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const NoExpenseContainerMobile(
                      title: 'Dates of expenses added will list here.')
              : Center(
                  child: NeumorphicLoader(
                    size: 75,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                );
        },
      ),
    );
  }
}
