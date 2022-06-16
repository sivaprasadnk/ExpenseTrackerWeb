import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentExpenseDetails extends StatefulWidget {
  const RecentExpenseDetails({
    Key? key,
    required this.expense,
    // required this.docId,
    // required this.title,
  }) : super(key: key);
  final RecentExpense expense;

  @override
  _RecentExpenseDetailsState createState() => _RecentExpenseDetailsState();
}

class _RecentExpenseDetailsState extends State<RecentExpenseDetails> {
  bool startedDelete = false;

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense.expenseTitle),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                startedDelete = true;
              });

              UserRepo()
                  .deleteExpense(
                      widget.expense.recentDocId,
                      widget.expense.expenseMonth,
                      widget.expense.expenseDate,
                      widget.expense.expenseDocId,
                      widget.expense.amount)
                  .then((value) {
                Provider.of<HomeProvider>(context, listen: false)
                    .deductFromdailyExpense(widget.expense.amount);
                Provider.of<HomeProvider>(context, listen: false)
                    .deductFromMonthlyTotal(widget.expense.amount);
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  if ((defaultTargetPlatform == TargetPlatform.android ||
                      defaultTargetPlatform == TargetPlatform.iOS)) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreenMobile.routeName, (r) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreenDesktop.routeName, (r) => false);
                  }
                });
              });
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 20,
            ),
          )
        ],
      ),
      body: !startedDelete
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(kUsersCollection)
                    .doc(userId)
                    .collection(kRecentExpensesCollection)
                    .doc(widget.expense.recentDocId)
                    // .collection(kExpenseCollection)
                    // .orderBy('updatedTime', descending: false)
                    .snapshots(),
                builder: (ct, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    //  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    // debugPrint('..${snapshot.data!["amount"].toString()}');
                  }
                  return snapshot.connectionState != ConnectionState.done
                      ? snapshot.hasData
                          ? Center(
                              child: SizedBox(
                                // height: 100,
                                child: Column(
                                  children: [
                                    Text(currency +
                                        " " +
                                        snapshot.data!["amount"].toString()),
                                    const SizedBox(height: 20),
                                    Text(snapshot.data!["details"].toString()),
                                    const SizedBox(height: 20),
                                    Text(snapshot.data!["updatedTime"]
                                        .toString()),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              height: screenHeight * 0.5,
                              child: const Center(
                                child: Text(
                                  'No Data !',
                                ),
                              ),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            )
          : const Center(
              child: Text('Please wait ...'),
            ),
    );
  }
}
