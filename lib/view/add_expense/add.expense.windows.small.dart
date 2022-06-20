import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/model/category.doc.model.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/view/add_expense/widgets/submit.button.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.container.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.title.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/select.category/select.category.screen.desktop2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddExpenseScreenDesktop extends StatefulWidget {
  const AddExpenseScreenDesktop({Key? key}) : super(key: key);

  static const routeName = 'AddExpense';

  @override
  _AddExpenseScreenStateDesktop createState() =>
      _AddExpenseScreenStateDesktop();
}

class _AddExpenseScreenStateDesktop extends State<AddExpenseScreenDesktop> {
  String expenseTitle = "";
  String expenseDetails = "";
  int expenseAmount = 0;

  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String formattedTime = "";

  final _formKey = GlobalKey<FormState>();

  CategoryDoc selectedCategory =
      CategoryDoc(name: 'Google Pay', id: 1, active: true, index: 1);
  Mode _selectedMode = Mode.cash;

  @override
  Widget build(BuildContext context) {
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    return DesktopView(
      isHome: false,
      appBarTitle: 'Add Expense',
      child: Center(
        child: SizedBox(
          width: 430,
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const TextFieldTitle(title: 'Amount'),
                        const SizedBox(
                          width: 10,
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            onSaved: (val) {
                              if (val != null && val.trim().isNotEmpty) {
                                debugPrint('.. @@ $val');
                                expenseAmount = int.parse(val.toString());
                              }
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const TextFieldTitle(title: 'Title'),
                        const SizedBox(
                          width: 30,
                        ),
                        TextFieldContainer(
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const TextFieldTitle(title: 'Category'),
                        const SizedBox(
                          width: 30,
                        ),
                        Icon(CategoryDoc.getIcon(selectedCategory.name)),
                        const SizedBox(
                          width: 20,
                        ),
                        TextFieldTitle(
                          title: selectedCategory.name,
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
                                            const SelectCategoryScreenDesktop2()))
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFieldTitle(title: 'Details'),
                        const SizedBox(
                          width: 15,
                        ),
                        TextFieldContainer(
                          height: 150,
                          child: TextFormField(
                            maxLines: 7,
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
                  GestureDetector(
                    onTap: () {
                      validateAndProceed();
                    },
                    child: const SubmitButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validateAndProceed() async {
    try {
      _formKey.currentState!.save();
      if (expenseAmount == 0) {
        throw CustomException(' Enter amount');
      }
      if (expenseTitle.trim().isEmpty) {
        throw CustomException(' Enter title');
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
