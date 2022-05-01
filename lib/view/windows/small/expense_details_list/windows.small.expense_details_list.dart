import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WindowsSmallExpenseDetailsList extends StatefulWidget {
  const WindowsSmallExpenseDetailsList({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  _WindowsSmallExpenseDetailsListState createState() =>
      _WindowsSmallExpenseDetailsListState();
}

class _WindowsSmallExpenseDetailsListState
    extends State<WindowsSmallExpenseDetailsList> {
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kExpenseDatesCollection)
              .doc(widget.title)
              .collection(kExpenseCollection)
              .orderBy('updatedTime', descending: false)
              .snapshots(),
          builder: (ctx, snapshot) {
            return snapshot.connectionState != ConnectionState.done
                ? snapshot.hasData
                    ? SizedBox(
                        height: screenHeight,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          itemCount:
                              (snapshot.data! as QuerySnapshot).docs.length,
                          itemBuilder: (_, index) {
                            var doc =
                                (snapshot.data! as QuerySnapshot).docs[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(doc['expense'].toString()),
                              ),
                            );
                          },
                        ),
                        // child: LiveList(
                        //   visibleFraction: 0.8,
                        //   showItemDuration: const Duration(milliseconds: 900),
                        //   padding: const EdgeInsets.only(left: 16, top: 10),
                        //   showItemInterval: const Duration(milliseconds: 50),
                        //   itemCount:
                        //       (snapshot.data! as QuerySnapshot).docs.length,
                        //   itemBuilder: animationItemBuilder(
                        //     (index) {
                        //       var doc =
                        //           (snapshot.data! as QuerySnapshot).docs[index];
                        //       return Padding(
                        //         padding: const EdgeInsets.only(bottom: 10),
                        //         child: WindowsSmallExpenseItem(
                        //           title: doc['expense'].toString(),
                        //           amount: doc['amount'].toString(),
                        //           docId: doc['expenseDocId'].toString(),
                        //           date: widget.title,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
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
