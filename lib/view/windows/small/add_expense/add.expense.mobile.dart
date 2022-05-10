import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/category.list.dart';
import 'package:expense_tracker/view/windows/small/add_expense/select.category.dart';
import 'package:expense_tracker/view/windows/small/home/windows.small.home.screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpenseMobile extends StatefulWidget {
  const AddExpenseMobile({Key? key}) : super(key: key);

  @override
  _AddExpenseMobileState createState() => _AddExpenseMobileState();
}

class _AddExpenseMobileState extends State<AddExpenseMobile> {
  String expenseTitle = "";
  String expenseDetails = "";
  int expenseAmount = 0;

  final DateTime now = DateTime.now();
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Expense'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Amount :',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rajdhani',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.cyan,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (val) {
                            expenseAmount = int.parse(val.toString());
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Title :',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rajdhani',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Category :',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rajdhani',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Icon(categoryList[selectedIndex].icon),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    categoryList[selectedIndex].name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rajdhani',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SelectCategory()))
                          .then((index) {
                        if (index != null) {
                          setState(() {
                            selectedIndex = index;
                          });
                        }
                      });
                    },
                    child: const Icon(
                      Icons.edit,
                    ),
                  )
                  // FaIcon(icon)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Details :',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rajdhani',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.cyan,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
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
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      validateAndProceed();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  validateAndProceed() async {
    var date = DateFormat('dd_MM_yyyy').format(selectedDate);
    var month = DateFormat('MMM_yyyy').format(selectedDate);
    int dailyTotal =
        Provider.of<HomeProvider>(context, listen: false).dailyTotalExpense;
    int monthlyTotal =
        Provider.of<HomeProvider>(context, listen: false).monthlyTotalExpense;
    // debugPrint('.. @@ datetime : $dateTime1');
    _formKey.currentState!.save();
    if (expenseTitle.isEmpty) {
      await showOkAlertDialog(
        context: context,
        title: 'Alert',
        message: 'Enter title',
      );
    } else {
      if (expenseAmount == 0) {
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
              .addExpenseNew(
            Expense(
              expenseTitle: expenseTitle,
              createdDate: "",
              expenseDocId: "",
              categoryIndex: selectedIndex,
              details: expenseDetails,
              amount: expenseAmount,
              categoryName: categoryList[selectedIndex].name,
              expenseMonth: month,
              expenseDate: date,
            ),
            dailyTotal,
            monthlyTotal,
          )
              .then((response) async {
            debugPrint('.. @@ response=> $response');
            if (response.status == ResponseStatus.error) {
              await showOkAlertDialog(
                context: context,
                title: 'Alert',
                message: response.message,
              );
            } else {
              showOkAlertDialog(context: context, title: 'Expense Added !')
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const WindowsSmallHome(),
                    ),
                    (r) => false);
              });
              // Provider.of<HomeProvider>(context, listen: false)
              //     .addToDailyExpense(expenseAmount);
              // Provider.of<HomeProvider>(context, listen: false)
              //     .addToMonthlyTotal(expenseAmount);

            }
          });
        }
      }
    }
  }
}
