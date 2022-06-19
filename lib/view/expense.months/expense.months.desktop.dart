import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.month.model.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.date.list/expense.date.list.desktop.small.screen.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.date.text.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.month.text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class ExpenseMonthsDesktop extends StatefulWidget {
  const ExpenseMonthsDesktop({Key? key}) : super(key: key);
  static const routeName = '/SelectMonth';

  @override
  State<ExpenseMonthsDesktop> createState() => _ExpenseMonthsDesktopState();
}

class _ExpenseMonthsDesktopState extends State<ExpenseMonthsDesktop> {
  List<bool> hoveredStatusList = List<bool>.generate(12, (index) => false);

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return DesktopView(
      isHome: false,

      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseMonthsCollection)
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData &&
                      (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? SizedBox(
                      width: 450,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          mainAxisExtent: 90,
                        ),
                        itemBuilder: (ctx, index) {
                          var doc =
                              (snapshot.data! as QuerySnapshot).docs[index];
                          var expenseMonth = ExpenseMonth.fromDb(doc);
                          return InkWell(
                            hoverColor: Colors.transparent,
                            onHover: (val) {
                              setState(() {
                                hoveredStatusList[index] = val;
                              });
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ExpenseDateListDesktopSmall(
                                      monthDocId: expenseMonth.monthDocId,
                                    ),
                                  ));
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    width: 130,
                                    height: 80,
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: !hoveredStatusList[index]
                                          ? bgColor
                                          : primaryColor,
                                      border: Border.all(
                                        width: 2,
                                        color: primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ExpenseDateText(
                                            date: expenseMonth.monthOnly,
                                            textColor: hoveredStatusList[index]
                                                ? bgColor
                                                : primaryColor,
                                          ),
                                          ExpenseMonthText(
                                            month: expenseMonth.year.toString(),
                                            textColor: hoveredStatusList[index]
                                                ? bgColor
                                                : primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // ExpenseAmountText(
                                //   fillColor: bgColor,
                                //   borderColor: primaryColor,
                                //   amount: expDate.totalExpense.toString(),
                                // )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container()
              : Center(
                  child: NeumorphicLoader(
                    size: 75,
                    borderColor: primaryColor,
                  ),
                );
        },
      ),
      appBarTitle: 'Select Month',
    );
  }
}
