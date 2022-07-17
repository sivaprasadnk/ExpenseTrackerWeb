import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/model/category.doc.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/utils/custom.exception.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/view/add.transaction/widgets/submit.button.dart';
import 'package:expense_tracker/view/add.transaction/widgets/textfield.container.dart';
import 'package:expense_tracker/view/add.transaction/widgets/textfield.title.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/select.category/select.category.screen.desktop2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTransactionScreenDesktop extends StatefulWidget {
  const AddTransactionScreenDesktop({Key? key}) : super(key: key);

  static const routeName = 'AddTransaction';

  @override
  _AddTransactionScreenDesktopState createState() =>
      _AddTransactionScreenDesktopState();
}

class _AddTransactionScreenDesktopState
    extends State<AddTransactionScreenDesktop> {
  String title = "";
  String details = "";

  int amount = 0;

  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String formattedTime = "";

  final _formKey = GlobalKey<FormState>();

  CategoryDoc selectedCategory =
      CategoryDoc(name: 'Google Pay', id: 1, active: true, index: 1);

  // Mode _selectedMode = Mode.cash;
  TransactionType _selectedType = TransactionType.income;

  @override
  Widget build(BuildContext context) {
    var date = formattedTime.isEmpty
        ? DateFormat('dd-MM-yyyy').format(now)
        : formattedTime;
    var currencySymbol =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return DesktopView(
      isHome: false,
      appBarTitle: 'Add Transaction',
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
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            onSaved: (val) {
                              if (val != null && val.trim().isNotEmpty) {
                                amount = int.parse(val.toString().trim());
                              }
                            },
                            decoration: InputDecoration(
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 5,
                                  top: 5,
                                  bottom: 10,
                                ),
                                child: Text(
                                  currencySymbol,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
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
                        const TextFieldTitle(title: 'Transaction Type'),
                        const SizedBox(
                          width: 23,
                        ),
                        Row(
                          children: [
                            Radio<TransactionType>(
                              value: TransactionType.income,
                              groupValue: _selectedType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value!;
                                });
                              },
                            ),
                            const TextFieldTitle(title: 'Income'),
                            const SizedBox(
                              width: 30,
                            ),
                            Radio<TransactionType>(
                              value: TransactionType.expense,
                              groupValue: _selectedType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value!;
                                });
                              },
                            ),
                            const TextFieldTitle(title: 'Expense'),
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
                              LengthLimitingTextInputFormatter(20),
                            ],
                            onSaved: (val) {
                              title = val.toString().trim();
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
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
                              details = val.toString().trim();
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
      if (amount == 0) {
        throw CustomException(' Enter amount');
      }
      if (title.isEmpty) {
        throw CustomException(' Enter title');
      }

      if (details.isEmpty) {
        throw CustomException(' Enter details');
      }
      debugPrint('.. @@ _selectedType :${_selectedType.name} ');

      UserController.addTransaction(
        selectedCategory.id,
        selectedCategory.name,
        amount,
        title,
        details,
        _selectedType,
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
