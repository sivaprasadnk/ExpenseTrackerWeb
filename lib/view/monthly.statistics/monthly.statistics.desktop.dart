import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/month.year.container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class MonthlyStatisticsDesktop extends StatefulWidget {
  const MonthlyStatisticsDesktop({Key? key}) : super(key: key);

  @override
  State<MonthlyStatisticsDesktop> createState() =>
      _MonthlyStatisticsDesktopState();
}

class _MonthlyStatisticsDesktopState extends State<MonthlyStatisticsDesktop> {
  ///
  var userId = FirebaseAuth.instance.currentUser!.uid;

  ///
  List<QueryDocumentSnapshot<Map<String, dynamic>>> monthDocList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryDocList = [];

  ///
  TransactionMonth? trans;

  ///
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();

  ///
  String monthDocId = '';
  String month = '';
  String year = '';
  String formattedTime = "";

  ///
  TransactionType selectedType = TransactionType.income;

  @override
  void initState() {
    monthDocId = DateFormat('MMM_yyyy').format(now);
    month = DateFormat('MMMM').format(now);
    year = DateFormat('yyyy').format(now);
    getData(monthDocId);
    super.initState();
  }

  getData(String monthDocId) async {
    var docSnapshot = await FirebaseFirestore.instance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kTransactionMonthsCollection)
        .where('monthDocId', isEqualTo: monthDocId)
        .get();

    monthDocList = docSnapshot.docs;

    var categoryDocSnapshot = await FirebaseFirestore.instance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kTransactionMonthsCollection)
        .doc(monthDocId)
        .collection(kTransactionCategoriesCollection)
        .get();

    categoryDocList = categoryDocSnapshot.docs;
    debugPrint('... @@$categoryDocList $categoryDocList');

    if (monthDocList.isNotEmpty) {
      QueryDocumentSnapshot doc = monthDocList[0];
      trans = TransactionMonth.fromDb(doc);
    } else {}
    if (categoryDocList.isNotEmpty) {
      // QueryDocumentSnapshot doc = monthDocList[0];

    }
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    var selectedDate1 =
        await SimpleMonthYearPicker.showMonthYearPickerDialog(context: context);
    if (selectedDate1 != null) {
      selectedDate = selectedDate1;
      monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
      month = DateFormat('MMMM').format(selectedDate);
      year = DateFormat('yyyy').format(selectedDate);
      getData(monthDocId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double btnWidth = 60;
    double btnHeight = 25;
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return DesktopView(
      child: Center(
        child: Container(
          width: 430,
          // height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 430,
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(
                    width: 1,
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 430,
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            'Monthly Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: bgColor,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: MonthYearContainer(month: month, year: year),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        if (monthDocList.isNotEmpty)
                          Text(
                            "${trans!.monthlyDrOrCr} $currency ${trans!.monthlyBalance}",
                            style: TextStyle(
                              height: 0.8,
                              fontSize: 53,
                              fontWeight: FontWeight.bold,
                              color: bgColor,
                            ),
                          )
                        else
                          Text(
                            "$currency 0",
                            style: TextStyle(
                              height: 0.8,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: bgColor,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Income',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: bgColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (monthDocList.isNotEmpty)
                              Text(
                                "$currency ${trans!.monthlyTotalIncome}",
                                style: TextStyle(
                                  height: 0.8,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: bgColor,
                                ),
                              )
                            else
                              Text(
                                "$currency 0",
                                style: TextStyle(
                                  height: 0.8,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: bgColor,
                                ),
                              )
                          ],
                        ),
                        const SizedBox(width: 25),
                        Container(
                          height: 75,
                          width: 3,
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Column(
                          children: [
                            Text(
                              'Expense',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: bgColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (monthDocList.isNotEmpty)
                              Text(
                                "$currency ${trans!.monthlyTotalExpense}",
                                style: TextStyle(
                                  height: 0.8,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: bgColor,
                                ),
                              )
                            else
                              Text(
                                "$currency 0",
                                style: TextStyle(
                                  height: 0.8,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: bgColor,
                                ),
                              )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: 430,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(
                    width: 1,
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = TransactionType.income;
                              });
                            },
                            child: Container(
                              height: btnHeight,
                              width: btnWidth,
                              decoration: BoxDecoration(
                                // border: Border.all(color: primaryColor),
                                color: selectedType == TransactionType.income
                                    ? bgColor
                                    : primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Income',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        selectedType == TransactionType.income
                                            ? primaryColor
                                            : bgColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = TransactionType.expense;
                              });
                            },
                            child: Container(
                              height: btnHeight,
                              width: btnWidth,
                              decoration: BoxDecoration(
                                // border: Border.all(color: primaryColor),
                                color: selectedType == TransactionType.expense
                                    ? bgColor
                                    : primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Expense',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        selectedType == TransactionType.income
                                            ? bgColor
                                            : primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: bgColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (categoryDocList.isNotEmpty)
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: categoryDocList.map((category) {
                          return Container(
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category.id,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 2,
              )
            ],
          ),
        ),
      ),
      appBarTitle: 'Statistics',
      isHome: false,
    );
  }
}
