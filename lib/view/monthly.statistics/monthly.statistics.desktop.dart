import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/model/monthly.data.response.model.dart';
import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/month.year.container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../expense.category.list/widgets/category.icon.dart';

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

  ///
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  ///
  List<TransactionCategoryModel> categoryList = [];

  TransactionCategoryModel selectedCategory = TransactionCategoryModel(
      categoryId: -1,
      categoryName: 'All',
      totalAmount: 0,
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
    final ThemeData theme = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
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
          height: MediaQuery.of(context).size.height * 0.9,
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
              Expanded(
                child: Container(
                  // height: 420,
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
                      const SizedBox(height: 20),
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bgColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (monthDocList.isNotEmpty)
                        if (categoryList.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 5,
                              children: categoryList.map((category) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectedCategory = category;
                                        setStream();
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: bgColor,
                                          ),
                                          color: selectedCategory.categoryId ==
                                                  category.categoryId
                                              ? bgColor
                                              : primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CategoryIcon(
                                            icon:
                                                getIcon(category.categoryName),
                                            color:
                                                selectedCategory.categoryId ==
                                                        category.categoryId
                                                    ? primaryColor
                                                    : bgColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      category.categoryName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: bgColor,
                                      ),
                                    )
                                  ],
                                );
                              }).toList(),
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
                      const SizedBox(height: 20),
                      Text(
                        'Transactions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bgColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (categoryList.isNotEmpty)
                        Expanded(
                          child: SizedBox(
                            // height: height * 0.3,
                            child: StreamBuilder(
                              stream: stream,
                              builder: (_, snapshot) {
                                return snapshot.connectionState !=
                                        ConnectionState.done
                                    ? snapshot.hasData &&
                                            (snapshot.data! as QuerySnapshot)
                                                .docs
                                                .isNotEmpty
                                        ? ListView.separated(
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(height: 5),
                                            shrinkWrap: true,
                                            itemCount: (snapshot.data!
                                                    as QuerySnapshot)
                                                .docs
                                                .length,
                                            itemBuilder: (_, index) {
                                              var doc = (snapshot.data!
                                                      as QuerySnapshot)
                                                  .docs[index];
                                              TransactionModel trans =
                                                  TransactionModel.fromJson(
                                                      doc);
                                              return TransactionListItem(
                                                trans: trans,
                                              );
                                            },
                                          )
                                        : SizedBox(
                                            child: Text(
                                              'No data found !!',
                                              style: TextStyle(color: bgColor),
                                            ),
                                          )
                                    : SizedBox(
                                        child: Text(
                                          'No data found !',
                                          style: TextStyle(color: bgColor),
                                        ),
                                      );
                              },
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Text(
                            'No Transactions !',
                            style: TextStyle(
                              color: bgColor,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                            ),
                          ),
                        )
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
      tempList.add(TransactionCategoryModel(
          categoryId: -1,
          categoryName: 'All',
          totalAmount: 0,
          transactionType: type.name.initCap()));
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

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key? key,
    required this.trans,
  }) : super(key: key);

  final TransactionModel trans;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    var drOrCr = trans.transactionType == "Income" ? "+" : "-";
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: bgColor,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              width: 7,
              height: 50,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  trans.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: bgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  trans.details,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: bgColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "$drOrCr $currency ${trans.amount}",
              style: TextStyle(
                fontSize: 35,
                color: bgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: bgColor,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
