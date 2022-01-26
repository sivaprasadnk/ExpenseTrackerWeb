import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/view/android/home/android.home.screen.dart';
import 'package:flutter/material.dart';

class AndroidAddExpenseForADateScreen extends StatefulWidget {
  const AndroidAddExpenseForADateScreen({
    Key? key,
    required this.date,
  }) : super(key: key);
  final String date;

  @override
  _AndroidAddExpenseForADateScreenState createState() =>
      _AndroidAddExpenseForADateScreenState();
}

class _AndroidAddExpenseForADateScreenState
    extends State<AndroidAddExpenseForADateScreen> {
  String expenseTitle = "";
  String expenseAmount = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  Text('Date : ${widget.date}'),
                  const SizedBox(width: 10),
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
              'Expense Amount : ',
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
            .addExpense(expenseTitle, expenseAmount, widget.date)
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
