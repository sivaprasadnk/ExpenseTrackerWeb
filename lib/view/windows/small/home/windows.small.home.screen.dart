import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/windows/small/add_expense/windows.small.add_expense.dart';
import 'package:expense_tracker/view/windows/small/home/windows.small.expense.date.item.dart';
import 'package:expense_tracker/view/windows/windows.splash.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WindowsSmallHome extends StatefulWidget {
  const WindowsSmallHome({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WindowsSmallHome> {
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
                        builder: (ctx) => const WindowsSplashScreen()));
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
                  builder: (ctx) => const WindowsSmallAddExpenseScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
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
                              padding: const EdgeInsets.only(left: 16, top: 10),
                              showItemInterval:
                                  const Duration(milliseconds: 50),
                              itemCount:
                                  (snapshot.data! as QuerySnapshot).docs.length,
                              itemBuilder: animationItemBuilder(
                                (index) {
                                  var doc = (snapshot.data! as QuerySnapshot)
                                      .docs[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: WindowsSmallExpenseDateItem(
                                      title: doc['day'].toString(),
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
            )
          ],
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
