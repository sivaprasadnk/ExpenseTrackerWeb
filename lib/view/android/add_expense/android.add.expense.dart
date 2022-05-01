import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/category.list.dart';
import 'package:expense_tracker/view/android/home/android.home.screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AndroidAddExpenseScreen extends StatefulWidget {
  const AndroidAddExpenseScreen({Key? key}) : super(key: key);

  @override
  _AndroidAddExpenseScreenState createState() =>
      _AndroidAddExpenseScreenState();
}

class _AndroidAddExpenseScreenState extends State<AndroidAddExpenseScreen> {
  String expenseTitle = "";
  String expenseAmount = "";
  String expenseDetails = "";
  final DateTime now = DateTime.now();
  // DateTime chosenDateTime =  DateTime.now();
  DateTime selectedDate = DateTime.now();
  String formattedTime = "";
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedTime = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  int selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    // var chosenDateTime = formattedTime.isEmpty ? now : selectedDate;
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Expense'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(date),
                  const SizedBox(width: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: const Text('Select Date'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Expense title : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.cyan,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      onSaved: (val) {
                        expenseTitle = val.toString();
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Expense details : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.cyan,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      maxLines: 3,
                      onSaved: (val) {
                        expenseDetails = val.toString();
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.cyan,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      onSaved: (val) {
                        expenseAmount = val.toString();
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                validateAndProceed();
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }

  validateAndProceed() async {
    var date = DateFormat('dd_MM_yyyy').format(selectedDate);
    var month = DateFormat('MMM_yyyy').format(selectedDate);
    _formKey.currentState!.save();
    if (expenseTitle.isEmpty) {
      await showOkAlertDialog(
        context: context,
        title: 'Alert',
        message: 'Enter title',
      );
    } else {
      if (expenseAmount.isEmpty) {
        await showOkAlertDialog(
          context: context,
          title: 'Alert',
          message: 'Enter Amount',
        );
      } else {
        if (expenseDetails.isEmpty) {
          await showOkAlertDialog(
            context: context,
            title: 'Alert',
            message: 'Enter details',
          );
        } else {
          UserRepo()
              .addExpense(
                  Expense(
                    title: expenseTitle,
                    categoryIndex: selectedCategoryIndex,
                    details: expenseDetails,
                    amount: 0,
                    categoryName: categoryList[selectedCategoryIndex].name,
                    expenseDate: date,
                    expenseMonth: month,
                  ),
                  0,
                  0)
              .then((response) async {
            debugPrint('.. @@ response=> $response');
            if (response.status == ResponseStatus.error) {
              await showOkAlertDialog(
                context: context,
                title: 'Alert',
                message: response.message,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const AndroidHomeScreen(),
                  ),
                  (r) => false);
            }
          });
        }
      }
    }
  }
}
