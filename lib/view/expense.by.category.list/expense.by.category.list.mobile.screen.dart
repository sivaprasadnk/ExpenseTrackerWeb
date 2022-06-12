import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.card.mobile.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/enums.dart';

class ExpenseByCategoryListMobileScreen extends StatefulWidget {
  const ExpenseByCategoryListMobileScreen(
      {Key? key, required this.categoryName})
      : super(key: key);
  final String categoryName;

  @override
  State<ExpenseByCategoryListMobileScreen> createState() =>
      _ExpenseByCategoryListMobileScreenState();
}

class _ExpenseByCategoryListMobileScreenState
    extends State<ExpenseByCategoryListMobileScreen> {
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
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var primaryColor = Theme.of(context).primaryColor;
    var bgColor = Theme.of(context).scaffoldBackgroundColor;
    double btnWidth = 60;
    double btnHeight = 25;

    return MobileView(
      appBarTitle: widget.categoryName,
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        color:
                            selectedMode == Mode.cash ? bgColor : primaryColor,
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
                    color: selectedMode == Mode.online ? primaryColor : bgColor,
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
                                var doc = (snapshot.data! as QuerySnapshot)
                                    .docs[index];
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
          ),
        ],
      ),
    );
  }
}
