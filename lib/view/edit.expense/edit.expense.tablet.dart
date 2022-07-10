import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/model/category.doc.model.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/view/add_expense/widgets/submit.button.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.container.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.title.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditExpenseScreenTablet extends StatefulWidget {
  const EditExpenseScreenTablet({Key? key, required this.expense})
      : super(key: key);

  final Expense expense;

  @override
  _EditExpenseScreenTabletState createState() =>
      _EditExpenseScreenTabletState();
}

class _EditExpenseScreenTabletState extends State<EditExpenseScreenTablet> {
  String expenseTitle = "";
  String expenseDetails = "";
  String formattedTime = "";

  int expenseAmount = 0;

  DateTime selectedDate = DateTime.now();
  final DateTime now = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  CategoryDoc selectedCategory =
      CategoryDoc(name: 'Google Pay', id: 1, active: true, index: 1);

  Mode _selectedMode = Mode.cash;

  @override
  void initState() {
    super.initState();
    var modeString = widget.expense.mode;
    if (modeString == 'Cash') {
      _selectedMode = Mode.cash;
    } else {
      _selectedMode = Mode.online;
    }
  }

  @override
  Widget build(BuildContext context) {
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    return MobileView(
      appBarTitle: 'Edit Expense',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.expense.expenseDate,
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
                          initialValue: widget.expense.amount.toString(),
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
                          initialValue: widget.expense.expenseTitle,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
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
                      Icon(CategoryDoc.getIcon(widget.expense.categoryName)),
                      const SizedBox(
                        width: 20,
                      ),
                      TextFieldTitle(
                        title: widget.expense.categoryName,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
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
                          initialValue: widget.expense.details,
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

      var exp = widget.expense;
      var newExpens = Expense(
        expenseTitle: expenseTitle,
        categoryId: exp.categoryId,
        details: expenseDetails,
        amount: expenseAmount,
        categoryName: exp.categoryName,
        expenseDate: exp.expenseDate,
        expenseDay: exp.expenseDay,
        expenseMonth: exp.expenseMonth,
        expenseMonthDocId: exp.expenseMonthDocId,
        createdDateTimeString: exp.createdDateTimeString,
        expenseDocId: exp.expenseDocId,
        recentDocId: exp.recentDocId,
        mode: _selectedMode.name,
      );
      UserController.editExpense(
        context: context,
        newExpense: newExpens,
        existingExpense: exp,
      );
    } on CustomException catch (exc) {
      Dialogs.showAlertDialog(context: context, description: exc.message);
    } catch (err) {
      Dialogs.showAlertDialog(
          context: context, description: 'Something went wrong !');
    }
  }
}
