import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/model/category.doc.model.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/view/add_expense/widgets/submit.button.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.title.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/select.category/select.category.screen.mobile2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddExpenseMobile extends StatefulWidget {
  const AddExpenseMobile({Key? key}) : super(key: key);
  static const routeName = '/AddExpense';
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
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       formattedTime = DateFormat('dd-MM-yyyy').format(selectedDate);
  //     });
  //   }
  // }

  final _formKey = GlobalKey<FormState>();

  Mode _selectedMode = Mode.cash;

  CategoryDoc selectedCategory =
      CategoryDoc(name: 'Google Pay', id: 1, active: true, index: 1);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    return MobileView(
      appBarTitle: 'Add expense',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
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
                          value: Mode.cash,
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
                          value: Mode.online,
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
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
                  Icon(CategoryDoc.getIcon(selectedCategory.name)),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    selectedCategory.name,
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
                      Navigator.push<CategoryDoc>(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const SelectCategoryScreenMobile2()))
                          .then((category) {
                        if (category != null) {
                          setState(() {
                            selectedCategory = category;
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
              const SizedBox(height: 50),
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
    try {
      _formKey.currentState!.save();
      if (expenseTitle.trim().isEmpty) {
        throw CustomException(' Enter title');
      }
      if (expenseAmount == 0) {
        throw CustomException(' Enter amount');
      }
      if (expenseDetails.trim().isEmpty) {
        throw CustomException(' Enter details');
      }
      UserController.addExpense(
        expenseTitle.trim(),
        selectedCategory.id,
        expenseDetails.trim(),
        expenseAmount,
        selectedCategory.name,
        _selectedMode,
        selectedDate,
        context,
      );
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(
          context: context, description: 'Something went wrong !');
    }
  }
}
