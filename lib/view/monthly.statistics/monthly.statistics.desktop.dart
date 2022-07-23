import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/model/monthly.data.response.model.dart';
import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/month.year.container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import 'view.transactions.container.dart';

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
  int touchedIndex = 0;

  ///
  List<QueryDocumentSnapshot<Map<String, dynamic>>> monthDocList = [];

  ///
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  ///
  List<TransactionCategoryModel> categoryList = [];

  TransactionCategoryModel selectedCategory = TransactionCategoryModel(
      categoryId: -1,
      categoryName: 'All',
      totalAmount: 0,
      lastUpdateTimeString: "12:34:56",
      transactionType: "Income");

  MonthlyDataResponseModel? monthlyDataResponseModel;

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
  String drOrCr = "+";

  ///
  TransactionType selectedType = TransactionType.income;

  @override
  void initState() {
    monthDocId = DateFormat('MMM_yyyy').format(now);
    month = DateFormat('MMMM').format(now);
    year = DateFormat('yyyy').format(now);
    getData();
    super.initState();
  }

  getData() async {
    monthlyDataResponseModel = await UserController.getMonthlyData(monthDocId);

    monthDocList = monthlyDataResponseModel!.monthDocList;
    if (monthDocList.isNotEmpty) {
      trans = monthlyDataResponseModel!.transactionMonth;
    }
    if (monthlyDataResponseModel!.categoryList!.isNotEmpty) {
      categoryList = monthlyDataResponseModel!.categoryList!;
    }
    filterCategories(selectedType);
  }

  Future<void> _selectDate(BuildContext context) async {
    var selectedDate1 =
        await SimpleMonthYearPicker.showMonthYearPickerDialog(context: context);
    if (selectedDate1 != null) {
      selectedDate = selectedDate1;
      monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
      month = DateFormat('MMMM').format(selectedDate);
      year = DateFormat('yyyy').format(selectedDate);
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    double btnWidth = 60;
    double btnHeight = 25;
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return DesktopView(
      child: Center(
        child: Container(
          width: 430,
          height: height * 0.9,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
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
              Expanded(
                child: Container(
                  height: height * 0.6,
                  width: 430,
                  padding:
                      const EdgeInsets.all(8) + const EdgeInsets.only(left: 10),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectedType = TransactionType.income;
                                filterCategories(selectedType);
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
                                selectedType = TransactionType.expense;
                                filterCategories(selectedType);
                              },
                              child: Container(
                                height: btnHeight,
                                width: btnWidth,
                                decoration: BoxDecoration(
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
                      const SizedBox(height: 20),
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bgColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (monthDocList.isNotEmpty)
                        if (categoryList.isNotEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SizedBox(
                                height: 105,
                                width: 105,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      setState(() {
                                        if (!event
                                                .isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection ==
                                                null) {
                                          touchedIndex = -1;
                                          return;
                                        }
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      });
                                    }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 30,
                                    sections: categoryList.map(
                                      (e) {
                                        String time = e.lastUpdateTimeString
                                            .split(' ')
                                            .last;

                                        int hr = int.tryParse(
                                            time.split(':').first)!;
                                        int min =
                                            int.tryParse(time.split(":")[1])!;
                                        int sec =
                                            int.tryParse(time.split(':').last)!;
                                        var red = hr + min + sec;
                                        var grn = min + hr + 150;
                                        var blu = 2 * hr + sec + 100;

                                        debugPrint(".. :$red,$grn,$blu");

                                        return PieChartSectionData(
                                          color: Color.fromRGBO(
                                            red,
                                            grn,
                                            blu,
                                            1,
                                          ),
                                          value: double.parse(
                                            e.totalAmount.toString(),
                                          ),
                                          title: e.categoryName,
                                          radius: 40,
                                          titleStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffffffff),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Center(
                            child: Text(
                              'No Categories !',
                              style: TextStyle(
                                color: bgColor,
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                              ),
                            ),
                          ),
                      SizedBox(
                        height: 40,
                        child: monthDocList.isNotEmpty &&
                                categoryList.isNotEmpty &&
                                categoryList.length > 3
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          'View All',
                                          style: TextStyle(
                                            color: bgColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: bgColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 15),
                      if (monthDocList.isNotEmpty)
                        if (categoryList.isNotEmpty)
                          SizedBox(
                            height: 140,
                            width: 430,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: categoryList.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (_, index) {
                                TransactionCategoryModel cat =
                                    categoryList[index];
                                return Stack(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 120,
                                      margin: const EdgeInsets.only(
                                          bottom: 15, top: 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: bgColor,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 15),
                                            Text(
                                              cat.categoryName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: bgColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              '$currency ${cat.totalAmount}',
                                              style: TextStyle(
                                                color: bgColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      top: 5,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: bgColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              cat.categoryName[0],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ViewTransactionsContainer(
                                        selectedType: selectedType,
                                        category: cat)
                                  ],
                                );
                              },
                            ),
                          ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              )
            ],
          ),
        ),
      ),
      appBarTitle: '',
      isHome: false,
    );
  }

  IconData getIcon(String category) {
    switch (category) {
      case "AutoFare":
        return FontAwesomeIcons.taxi;
      case "BusFare":
        return FontAwesomeIcons.taxi;
      case "BottleWater":
        return FontAwesomeIcons.bottleWater;
      case "Food":
        return FontAwesomeIcons.bowlFood;
      default:
        return FontAwesomeIcons.googlePay;
    }
  }

  void filterCategories(TransactionType type) {
    categoryList = monthlyDataResponseModel!.categoryList!;

    List<TransactionCategoryModel> tempList = [];

    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].transactionType == type.name.initCap()) {
        debugPrint('.. here');
        tempList.add(categoryList[i]);
      }
    }
    if (tempList.isNotEmpty && tempList.length > 1) {
      // tempList.add(TransactionCategoryModel(
      //     categoryId: -1,
      //     categoryName: 'All',
      //     lastUpdateTimeString: "12:34:56",
      //     totalAmount: 0,
      //     transactionType: type.name.initCap()));
    }

    tempList.sort(((a, b) => a.categoryId.compareTo(b.categoryId)));

    categoryList = tempList;
    if (categoryList.isNotEmpty) {
      selectedCategory = categoryList[0];
    }
    setStream();
    setState(() {});
  }

  setStream() {
    if (selectedCategory.categoryId != -1) {
      stream = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentTransactionCollection)
          .where('transactionMonthDocId', isEqualTo: monthDocId)
          .where('transactionType', isEqualTo: selectedType.name.initCap())
          .where('categoryId', isEqualTo: selectedCategory.categoryId)
          .orderBy('createdDateTime', descending: true)
          .snapshots();
    } else {
      stream = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentTransactionCollection)
          .where('transactionMonthDocId', isEqualTo: monthDocId)
          .where('transactionType', isEqualTo: selectedType.name.initCap())
          .orderBy('createdDateTime', descending: true)
          .snapshots();
    }
  }
}
