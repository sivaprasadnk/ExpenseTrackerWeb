import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.date.model.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/windows/small/expense.by.date.list/expense.by.date.list.screen.dart';
import 'package:expense_tracker/view/windows/small/expense.by.date/widgets/expense.date.text.dart';
import 'package:expense_tracker/view/windows/small/expense.by.date/widgets/expense.month.text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseByDateScreen extends StatelessWidget {
  const ExpenseByDateScreen({Key? key}) : super(key: key);

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
                                      builder: (_) => ExpenseByDateListScreen(
                                            expenseDateItem: expDate,
                                          )));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                // color: Colors.cyan,
                                border: Border.all(
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ExpenseDateText(date: expDate.date),
                                  ExpenseMonthText(
                                    month: expDate.month,
                                  ),
                                ],
                              ),
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
