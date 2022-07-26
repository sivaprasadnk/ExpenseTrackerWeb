import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/model/monthly.data.response.model.dart';
import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/model/transaction.month.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/provider/statistics.provider.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/month.year.container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class DailySummaryContainer extends StatefulWidget {
  const DailySummaryContainer({Key? key}) : super(key: key);

  @override
  State<DailySummaryContainer> createState() => _DailySummaryContainerState();
}

class _DailySummaryContainerState extends State<DailySummaryContainer> {
  ///
  String monthDocId = '';
  String month = '';
  String year = '';
  String formattedTime = "";
  String drOrCr = "+";

  DateTime selectedDate = DateTime.now();

  DataResponseModel? dataResponseModel;

  @override
  void initState() {
    monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
    month = DateFormat('MMMM').format(selectedDate);
    year = DateFormat('yyyy').format(selectedDate);
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;

    return Container(
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
                const Text('Daily Total').boldBgColorTextWithSize(context, 20),
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
          Consumer<StatisticsProvider>(
            builder: (_, provider, __) {
              return Row(
                children: [
                  const SizedBox(width: 20),
                  if (provider.monthDocList!.isNotEmpty)
                    Text(
                      "${provider.transacationMonth!.monthlyDrOrCr} $currency ${provider.transacationMonth!.monthlyBalance}",
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
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<StatisticsProvider>(
                builder: (_, provider, __) {
                  return Column(
                    children: [
                      const Text('Income').boldBgColorTextWithSize(context, 15),
                      const SizedBox(height: 10),
                      if (provider.monthDocList!.isNotEmpty)
                        Text(
                          "$currency ${provider.transacationMonth!.monthlyTotalIncome}",
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
                  );
                },
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
              Consumer<StatisticsProvider>(
                builder: (_, provider, __) {
                  return Column(
                    children: [
                      const Text('Expense')
                          .boldBgColorTextWithSize(context, 15),
                      const SizedBox(height: 10),
                      if (provider.monthDocList!.isNotEmpty)
                        Text(
                          "$currency ${provider.transacationMonth!.monthlyTotalExpense}",
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
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    var selectedDate1 =
        await SimpleMonthYearPicker.showMonthYearPickerDialog(context: context);
    if (selectedDate1 != null) {
      StatisticsProvider provider = context.read<StatisticsProvider>();

      selectedDate = selectedDate1;
      monthDocId = DateFormat('MMM_yyyy').format(selectedDate);
      month = DateFormat('MMMM').format(selectedDate);
      provider.updateSelectedMonthDocId(monthDocId);
      year = DateFormat('yyyy').format(selectedDate);
      getData();
    }
  }

  getData() async {
    TransactionMonth? trans;
    var date = DateFormat('dd-MM-yyyy').format(selectedDate);

    dataResponseModel = await UserController.getDailyData(date);

    var dateDocList = dataResponseModel!.dataDocList;
    if (dateDocList.isNotEmpty) {
      trans = dataResponseModel!.transactionMonth;
    }
    if (dataResponseModel!.categoryList!.isNotEmpty) {}
    // context.read<StatisticsProvider>().updateMonthDocList(monthDocList);
    if (dateDocList.isNotEmpty) {
      context.read<StatisticsProvider>().updateMonth(trans!);
    }

    filterCategories();
  }

  void filterCategories() {
    StatisticsProvider provider = context.read<StatisticsProvider>();

    List<TransactionCategoryModel>? categoryList =
        dataResponseModel!.categoryList!;

    List<TransactionCategoryModel> tempList = [];
    provider.updateCategoryList(categoryList);

    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].transactionType == 'Income') {
        tempList.add(categoryList[i]);
      }
    }

    tempList.sort(((a, b) => a.categoryId.compareTo(b.categoryId)));

    categoryList = tempList;
    if (categoryList.isNotEmpty) {
      setStream(categoryList[0].categoryId);
    }
    provider.updateSelectedType(TransactionType.income);
    provider.updateFilteredCategoryList(categoryList);
    // var type = transactionType.name.initCap();
  }

  setStream(
    int categoryId,
  ) {
    StatisticsProvider provider = context.read<StatisticsProvider>();

    var userId = FirebaseAuth.instance.currentUser!.uid;

    if (categoryId != -1) {
      var stream = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentTransactionCollection)
          .where('transactionMonthDocId', isEqualTo: monthDocId)
          .where('transactionType', isEqualTo: 'Income')
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('createdDateTime', descending: true)
          .snapshots();
      provider.updateStream(stream);
    } else {
      var stream = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kRecentTransactionCollection)
          .where('transactionMonthDocId', isEqualTo: monthDocId)
          .where('transactionType', isEqualTo: 'Income')
          .orderBy('createdDateTime', descending: true)
          .snapshots();

      provider.updateStream(stream);
    }
  }
}
