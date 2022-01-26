import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
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
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
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
        UserRepo()
            .addExpense(expenseTitle, expenseAmount,
                DateFormat('dd-MM-yyyy').format(selectedDate))
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
