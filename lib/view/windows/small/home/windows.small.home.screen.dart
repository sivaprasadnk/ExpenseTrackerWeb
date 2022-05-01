import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/windows/small/add_expense/add.expense.mobile.dart';
import 'package:expense_tracker/view/windows/small/add_expense/windows.small.add_expense.dart';
import 'package:expense_tracker/view/windows/small/home/windows.small.expense.date.item.dart';
import 'package:expense_tracker/view/windows/small/recent/windows.small.recent.list.dart';
import 'package:expense_tracker/view/windows/windows.splash.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WindowsSmallHome extends StatefulWidget {
  const WindowsSmallHome({Key? key}) : super(key: key);
  static const routeName = '/Home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WindowsSmallHome> {
  String todaysTotal = "0";

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
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
      body: Container(
        height: screenHeight,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.cyan,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Todays Total Expense :',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Rajdhani',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Consumer<HomeProvider>(
                      builder: (_, provider, __) {
                        return Text(
                          provider.dailyTotalExpense.toString(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Rajdhani',
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                // width: screenWidth * 0.9,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 150,
                      width: screenWidth * 0.27,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Monthy Total  :',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Rajdhani',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Consumer<HomeProvider>(
                            builder: (_, provider, __) {
                              return Text(
                                provider.monthlyTotalExpense.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Rajdhani',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 150,
                      width: screenWidth * 0.27,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Weekly Total  :',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Rajdhani',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' Rs.1000',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rajdhani',
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (defaultTargetPlatform == TargetPlatform.android) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const AddExpenseMobile()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      const WindowsSmallAddExpenseScreen()));
                        }
                      },
                      child: Container(
                        height: 150,
                        width: screenWidth * 0.27,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.cyan,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Add ',
                            style: TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recent Expenses',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Rajdhani',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.4,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(kUsersCollection)
                      .doc(userId)
                      .collection(kRecentExpensesCollection)
                      .limit(5)
                      .orderBy('createdDate', descending: true)
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
                                        child: WindowsSmallExpenseDateItem(
                                          title: doc['expenseTitle'].toString(),
                                          total: doc['amount'].toString(),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WindowsSmallRecentList()));
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: 'Rajdhani',
                        color: Colors.cyan,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
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
