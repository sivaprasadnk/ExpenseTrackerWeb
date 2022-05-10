import 'package:expense_tracker/view/windows/small/expense.by.date/expense.by.date.screen.dart';
import 'package:expense_tracker/view/windows/small/home/add.expense.button.dart';
import 'package:expense_tracker/view/windows/small/home/daily.total.text.dart';
import 'package:expense_tracker/view/windows/small/home/recent.expenses.list.container.dart';
import 'package:expense_tracker/view/windows/small/home/sign.out.icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WindowsSmallHome extends StatefulWidget {
  const WindowsSmallHome({Key? key}) : super(key: key);
  static const routeName = '/Home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WindowsSmallHome> {
  String todaysTotal = "0";
  // final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // var month = DateFormat('MMM_yyyy').format(now);
    // var date = DateFormat('dd_MM_yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        actions: [SignOutIcon()],
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
                    DailyTotalText(),
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
                    // Container(
                    //   height: 150,
                    //   width: screenWidth * 0.27,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: Colors.cyan,
                    //     ),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       const Text(
                    //         'Monthy Total  :',
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           fontFamily: 'Rajdhani',
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       MonthlyTotalText(),
                    //       // Consumer<HomeProvider>(
                    //       //   builder: (_, provider, __) {
                    //       //     return Text(
                    //       //       provider.monthlyTotalExpense.toString(),
                    //       //       style: const TextStyle(
                    //       //         fontFamily: 'Rajdhani',
                    //       //         fontSize: 15,
                    //       //         fontWeight: FontWeight.bold,
                    //       //         color: Colors.red,
                    //       //       ),
                    //       //     );
                    //       //   },
                    //       // )
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ExpenseByDate()),
                        );
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'View Expenses',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Rajdhani',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' by Date',
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
                            'View Expenses',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Rajdhani',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' by Category',
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
                    AddExpenseButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Expenses',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Rajdhani',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    // ViewAllText(),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              RecentExpensesListContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
