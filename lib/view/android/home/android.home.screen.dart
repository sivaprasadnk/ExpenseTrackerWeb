import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/android/add_expense/android.add.expense.dart';
import 'package:expense_tracker/view/android/android.splash_screen.dart';
import 'package:expense_tracker/view/android/home/android.expense.date.item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AndroidHomeScreen extends StatefulWidget {
  const AndroidHomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AndroidHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // FirebaseFirestore.instance.collection(kUsersCollection)
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const AndroidSplashScreen()));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => const AndroidAddExpenseScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: screenHeight * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: screenHeight * 0.8,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(kUsersCollection)
                      .doc(userId)
                      .collection(kExpenseDatesCollection)
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState != ConnectionState.done
                        ? snapshot.hasData
                            ? SizedBox(
                                height: screenHeight * 0.5,
                                child: LiveList(
                                  visibleFraction: 0.8,
                                  showItemDuration:
                                      const Duration(milliseconds: 900),
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 10),
                                  showItemInterval:
                                      const Duration(milliseconds: 50),
                                  itemCount: (snapshot.data! as QuerySnapshot)
                                      .docs
                                      .length,
                                  itemBuilder: animationItemBuilder(
                                    (index) {
                                      var doc =
                                          (snapshot.data! as QuerySnapshot)
                                              .docs[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: AndroidExpenseDateItem(
                                          title: doc['day'].toString(),
                                          total: doc['totalExpense'].toString(),
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
              )
            ],
          ),
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
