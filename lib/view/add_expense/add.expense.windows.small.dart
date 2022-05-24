import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/controller/add.expense.controller.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/utils/category.list.dart';
import 'package:expense_tracker/view/add_expense/select.category.screen.dart';
import 'package:expense_tracker/view/add_expense/widgets/submit.button.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.container.dart';
import 'package:expense_tracker/view/add_expense/widgets/textfield.title.dart';
import 'package:expense_tracker/view/desktop.view.dart';
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
    return DesktopView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        // try {
                        if (val != null && val.trim().isNotEmpty) {
                          debugPrint('.. @@ $val');
                          expenseAmount = int.parse(val.toString());
                        }
                        // } catch (err) {
                        //   showOkAlertDialog(
                        //     context: context,
                        //     title: 'Alert',
                        //     style: AdaptiveStyle.material,
                        //     message: 'Amount should be number',
                        //   );
                        // }
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
                  TextFieldTitle(title: CategoryList.list[selectedIndex].name),

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
                  const TextFieldTitle(title: 'Details'),
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
            GestureDetector(
              onTap: () {
                validateAndProceed();
              },
              child: const SubmitButton(),
            ),
          ],
        ),
      ),
    );
  }

  validateAndProceed() async {
    var date = DateFormat('dd-MM-yyyy').format(selectedDate);
    var month = DateFormat('MMM, yyyy').format(selectedDate);
    try {
      _formKey.currentState!.save();
      if (expenseTitle.trim().isEmpty) {
        debugPrint('.. @@ hereeeeeeee2');
        await showOkAlertDialog(
          context: context,
          title: 'Alert',
          message: 'Enter title',
        );
      } else {
        debugPrint('.. @@ hereeeeeeee5');

        if (expenseAmount == 0) {
          debugPrint('.. @@ hereeeeeeee5');

          await showOkAlertDialog(
            context: context,
            title: 'Alert',
            style: AdaptiveStyle.material,
            message: 'Enter Amount',
          );
        } else {
          if (expenseDetails.isEmpty) {
            debugPrint('.. @@ hereeeeeeee4');

            await showOkAlertDialog(
              context: context,
              title: 'Alert',
              message: 'Enter details',
            );
          } else {
            debugPrint('.. @@ hereeeeeeee3');

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
