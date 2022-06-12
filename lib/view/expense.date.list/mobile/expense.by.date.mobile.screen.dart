import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.date.model.dart';
import 'package:expense_tracker/view/expense.by.date.list/expense.by.date.list.mobile.screen.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.amount.text.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.date.text.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.month.text.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class ExpenseByDateMobileScreen extends StatefulWidget {
  const ExpenseByDateMobileScreen({Key? key}) : super(key: key);

  @override
  _ExpenseByDateMobileScreenState createState() =>
      _ExpenseByDateMobileScreenState();
}

class _ExpenseByDateMobileScreenState extends State<ExpenseByDateMobileScreen> {
  bool show = false;

  ///

  ///
  String monthDocId = '';
  String month = '';
  String year = '';
  String formattedTime = "";

  ///
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    monthDocId = DateFormat('MMM_yyyy').format(now);
    month = DateFormat('MMMM').format(now);
    year = DateFormat('yyyy').format(now);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    var selectedDate1 =
        await SimpleMonthYearPicker.showMonthYearPickerDialog(context: context);
    if (selectedDate1 != null) {
      selectedDate = selectedDate1;
      setState(() {
        monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
        month = DateFormat('MMMM').format(selectedDate);
        year = DateFormat('yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;

    return MobileView(
      appBarTitle: 'Select Date',
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                // width: 111,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        month + ", " + year,
                        style: TextStyle(
                          color: bgColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: bgColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(kUsersCollection)
                  .doc(userId)
                  .collection(kExpenseDatesNewCollection)
                  .where('monthDocId', isEqualTo: monthDocId)
                  .orderBy('day', descending: false)
                  .snapshots(),
              builder: (_, snapshot) {
                return snapshot.connectionState != ConnectionState.done
                    ? snapshot.hasData &&
                            (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                        ? Center(
                            child: SizedBox(
                              width: 450,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: (snapshot.data! as QuerySnapshot)
                                    .docs
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  mainAxisExtent: 90,
                                ),
                                itemBuilder: (ctx, index) {
                                  var doc = (snapshot.data! as QuerySnapshot)
                                      .docs[index];
                                  var expDate = ExpenseDate.fromJson(doc);
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ExpenseByDateListMobileScreen(
                                                    expenseDateItem: expDate,
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.zero,
                                          width: 130,
                                          height: 150,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: primaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ExpenseDateText(
                                                  date: expDate.day,
                                                  textColor: primaryColor,
                                                ),
                                                ExpenseMonthText(
                                                  month: expDate.month,
                                                  textColor: primaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ExpenseAmountText(
                                          borderColor: primaryColor,
                                          fillColor: bgColor,
                                          amount:
                                              expDate.totalExpense.toString(),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : const NoExpenseContainerMobile(
                            title: 'Dates of expenses added will list here.')
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
    );
  }
}
