import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.date.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.desktop.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/total.expense.container.desktop.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class ExpenseListByDateDesktopScreen extends StatefulWidget {
  const ExpenseListByDateDesktopScreen({
    Key? key,
    required this.expenseDateItem,
  }) : super(key: key);
  final ExpenseDate expenseDateItem;

  @override
  State<ExpenseListByDateDesktopScreen> createState() =>
      _ExpenseListByDateDesktopScreenState();
}

class _ExpenseListByDateDesktopScreenState
    extends State<ExpenseListByDateDesktopScreen> {
  ///
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  ///
  var userId = FirebaseAuth.instance.currentUser!.uid;

  ///
  final cloudStoreInstance = FirebaseFirestore.instance;

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
        .collection(kExpenseDatesNewCollection)
        .doc(widget.expenseDateItem.date)
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
    double btnWidth = 60;
    double btnHeight = 25;
    var theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return DesktopView(
      isHome: false,
      appBarTitle: widget.expenseDateItem.date,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TotalExpenseContainerDesktop(
              totalExpense: widget.expenseDateItem.totalExpense,
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
                  return snapshot.hasData
                      ? (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                          ? SizedBox(
                              child: ListView.separated(
                                separatorBuilder: (ctx, _) => const SizedBox(
                                  height: 10,
                                ),
                                itemCount: (snapshot.data! as QuerySnapshot)
                                    .docs
                                    .length,
                                itemBuilder: (ctx, index) {
                                  var doc = (snapshot.data! as QuerySnapshot)
                                      .docs[index];
                                  Expense expense = Expense.fromJson(doc);
                                  return Center(
                                    child: SizedBox(
                                      width: 450,
                                      child: ExpenseDetailsCardDesktop(
                                        expense: expense,
                                        // width: 450,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const NoExpenseContainerDesktop(
                              title: 'No Expenses added',
                            )
                      : Center(
                          child: NeumorphicLoader(
                            size: 75,
                            borderColor: primaryColor,
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
