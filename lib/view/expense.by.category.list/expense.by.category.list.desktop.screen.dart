import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop/expense.details.card.desktop.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/total.expense.container.desktop.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

import '../../utils/enums.dart';

class ExpenseByCategoryListDesktopScreen extends StatefulWidget {
  const ExpenseByCategoryListDesktopScreen(
      {Key? key, required this.categoryName, required this.totalAmount})
      : super(key: key);

  ///
  final String categoryName;
  final int totalAmount;

  @override
  State<ExpenseByCategoryListDesktopScreen> createState() =>
      _ExpenseByCategoryListDesktopScreenState();
}

class _ExpenseByCategoryListDesktopScreenState
    extends State<ExpenseByCategoryListDesktopScreen> {
  ///
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  ///
  var userId = FirebaseAuth.instance.currentUser!.uid;

  ///
  Mode selectedMode = Mode.all;

  @override
  void initState() {
    setStream(Mode.all);

    super.initState();
  }

  setStream(Mode mode) {
    final collectionRef = FirebaseFirestore.instance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseCategoriesCollection)
        .doc(widget.categoryName)
        .collection(kExpenseCollection);
    if (mode == Mode.all) {
      setState(() {
        stream = collectionRef
            .orderBy('createdDateTimeString', descending: true)
            .snapshots();
        selectedMode = Mode.all;
      });
    } else if (mode == Mode.cash) {
      setState(() {
        stream = collectionRef
            .where('mode', isEqualTo: 'Cash')
            .orderBy('createdDateTimeString', descending: true)
            .snapshots();
        selectedMode = Mode.cash;
      });
    } else {
      setState(() {
        stream = collectionRef
            .where('mode', isEqualTo: 'Online')
            .orderBy('createdDateTimeString', descending: true)
            .snapshots();
        selectedMode = Mode.online;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var bgColor = Theme.of(context).scaffoldBackgroundColor;
    double btnWidth = 60;
    double btnHeight = 25;
    return DesktopView(
      isHome: false,
      appBarTitle: '',
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TotalExpenseContainerDesktop(
              totalExpense: widget.totalAmount,
              title: widget.categoryName,
              cashTotal: "0",
              onlineTotal: "0",
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Mode :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setStream(Mode.all);
                  },
                  child: Container(
                    height: btnHeight,
                    width: btnWidth,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      color: selectedMode == Mode.all ? primaryColor : bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              selectedMode == Mode.all ? bgColor : primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setStream(Mode.cash);
                  },
                  child: Container(
                    height: btnHeight,
                    width: btnWidth,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      color: selectedMode == Mode.cash ? primaryColor : bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Cash',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedMode == Mode.cash
                              ? bgColor
                              : primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setStream(Mode.online);
                  },
                  child: Container(
                    height: btnHeight,
                    width: btnWidth,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      color:
                          selectedMode == Mode.online ? primaryColor : bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Online',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedMode == Mode.online
                              ? bgColor
                              : primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream: stream,
                builder: (_, snapshot) {
                  return snapshot.connectionState != ConnectionState.done
                      ? snapshot.hasData &&
                              (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (ctx, _) => const SizedBox(
                                height: 10,
                              ),
                              itemCount:
                                  (snapshot.data! as QuerySnapshot).docs.length,
                              itemBuilder: (ctx, index) {
                                var doc = (snapshot.data! as QuerySnapshot)
                                    .docs[index];
                                Expense expense = Expense.fromJson(doc);
                                return Center(
                                  child: SizedBox(
                                    width: 450,
                                    child: ExpenseDetailsCardDesktop(
                                      expense: expense,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const NoExpenseContainerDesktop(
                              title: 'No expense added !',
                            )
                      : Center(
                          child: NeumorphicLoader(
                            size: 75,
                            borderColor: Theme.of(context).primaryColor,
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
