import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/controller/add.expense.controller.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/utils/category.list.dart';
import 'package:expense_tracker/view/add_expense/select.category.screen.dart';
import 'package:expense_tracker/view/add_expense/widgets/submit.button.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.title.dart';
import 'package:expense_tracker/view/mobile.view.dart';
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
  Mode _selectedMode = Mode.Cash;

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.cardColor;
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    return MobileView(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Center(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       _selectDate(context);
                  //     },
                  //     child: const Text('Select Date'),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextFieldTitle(title: 'Amount'),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: primaryColor,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (val) {
                            if (val != null && val.trim().isNotEmpty) {
                              expenseAmount = int.parse(val.toString());
                            }
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
                        const TextFieldTitle(title: 'Cash'),
                        const SizedBox(
                          width: 30,
                        ),
                        Radio<Mode>(
                          value: Mode.Online,
                          groupValue: _selectedMode,
                          onChanged: (value) {
                            setState(() {
                              _selectedMode = value!;
                            });
                          },
                        ),
                        const TextFieldTitle(title: 'Online'),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Title :',
                    style: TextStyle(
                      fontSize: 15,
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
                        color: primaryColor,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Icon(CategoryList.list[selectedIndex].icon),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    CategoryList.list[selectedIndex].name,
                    style: const TextStyle(
                      fontSize: 15,
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
                      // fontFamily: 'Rajdhani',
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
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: primaryColor,
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
              GestureDetector(
                onTap: () {
                  validateAndProceed();
                },
                child: const SubmitButton(
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateAndProceed() async {
    var date = DateFormat('dd-MM-yyyy').format(selectedDate);
    var month = DateFormat('MMM, yyyy').format(selectedDate);
    try {
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
    } catch (err) {
      await showOkAlertDialog(
        context: context,
        title: 'Alert',
        message: 'Something went wrong !',
      );
    }
  }
}
