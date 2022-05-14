import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/controller/add.expense.controller.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/category.list.dart';
import 'package:expense_tracker/view/windows/small/add_expense/select.category.screen.dart';
import 'package:expense_tracker/view/windows/small/add_expense/widgets/submit.button.dart';
import 'package:expense_tracker/view/windows/small/add_expense/widgets/textfield.container.dart';
import 'package:expense_tracker/view/windows/small/add_expense/widgets/textfield.title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WindowsSmallAddExpenseScreen extends StatefulWidget {
  const WindowsSmallAddExpenseScreen({Key? key}) : super(key: key);

  @override
  _WindowsSmallAddExpenseScreenState createState() =>
      _WindowsSmallAddExpenseScreenState();
}

class _WindowsSmallAddExpenseScreenState
    extends State<WindowsSmallAddExpenseScreen> {
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
  Mode _selectedMode = Mode.Cash;

  @override
  Widget build(BuildContext context) {
    // final ThemeNotifier theme =
    //     Provider.of<ThemeNotifier>(context, listen: true);
    // var primaryColor = theme.themeData.primaryColor;
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Add Expense',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            validateAndProceed();
          },
          child: SubmitButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    const TextFieldTitle(title: 'Amount'),
                    const SizedBox(
                      width: 10,
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        onSaved: (val) {
                          expenseAmount = int.parse(val.toString());
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    const TextFieldTitle(title: 'Mode'),
                    const SizedBox(
                      width: 23,
                    ),
                    Row(
                      children: [
                        Radio<Mode>(
                          value: Mode.Cash,
                          groupValue: _selectedMode,
                          onChanged: (value) {
                            setState(() {
                              _selectedMode = value!;
                            });
                          },
                        ),
                        TextFieldTitle(title: 'Cash'),
                        SizedBox(
                          width: 30,
                        ),
                        Radio<Mode>(
                          value: Mode.GooglePay,
                          groupValue: _selectedMode,
                          onChanged: (value) {
                            setState(() {
                              _selectedMode = value!;
                            });
                          },
                        ),
                        TextFieldTitle(title: 'GooglePay'),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    const TextFieldTitle(title: 'Title'),
                    const SizedBox(
                      width: 30,
                    ),
                    TextFieldContainer(
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    const TextFieldTitle(title: 'Category'),

                    const SizedBox(
                      width: 30,
                    ),
                    Icon(CategoryList.list[selectedIndex].icon),
                    const SizedBox(
                      width: 20,
                    ),
                    TextFieldTitle(
                        title: CategoryList.list[selectedIndex].name),

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
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitle(title: 'Details'),
                    const SizedBox(
                      width: 15,
                    ),
                    TextFieldContainer(
                      height: 150,
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  validateAndProceed() async {
    var date = DateFormat('dd_MM_yyyy').format(selectedDate);
    var month = DateFormat('MMM, yyyy').format(selectedDate);

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
          AddExpenseController().addExpense(
              expenseTitle,
              selectedIndex,
              expenseDetails,
              expenseAmount,
              CategoryList.list[selectedIndex].name,
              month,
              date,
              _selectedMode,
              context);
        }
      }
    }
  }
}
