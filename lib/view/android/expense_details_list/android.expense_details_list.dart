import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/android/expense_details_list/android.expense.list.item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AndroidExpenseDetailsList extends StatefulWidget {
  const AndroidExpenseDetailsList({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  _AndroidExpenseDetailsState createState() => _AndroidExpenseDetailsState();
}

class _AndroidExpenseDetailsState extends State<AndroidExpenseDetailsList> {
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (ctx) => AndroidAddExpenseForADateScreen(
          //               date: widget.title,
          //             )));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseDatesCollection)
            .doc(widget.title)
            .collection(kExpenseCollection)
            .orderBy(
              'updatedTime',
              descending: false,
            )
            .snapshots(),
        builder: (ctx, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData
                  ? SizedBox(
                      height: screenHeight * 0.9,
                      child: LiveList(
                        visibleFraction: 0.8,
                        showItemDuration: const Duration(milliseconds: 900),
                        padding: const EdgeInsets.only(left: 16, top: 10),
                        showItemInterval: const Duration(milliseconds: 50),
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        itemBuilder: animationItemBuilder(
                          (index) {
                            var doc =
                                (snapshot.data! as QuerySnapshot).docs[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: AndroidExpenseListItem(
                                title: doc['expense'].toString(),
                                amount: doc['amount'].toString(),
                                docId: doc['expenseDocId'].toString(),
                                date: widget.title,
                              ),
                            );
                          },
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
    );
  }

  Widget Function(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) animationItemBuilder(
    Widget Function(int index) child, {
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child(index),
              ),
            ),
          );
}
