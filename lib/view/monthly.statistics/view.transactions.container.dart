import 'package:expense_tracker/model/transaction.category.model.dart';
import 'package:expense_tracker/utils/enums.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/category.transactions.list/category.transactions.list.desktop.dart';
import 'package:flutter/material.dart';

class ViewTransactionsContainer extends StatelessWidget {
  const ViewTransactionsContainer({
    Key? key,
    required this.selectedType,
    required this.category,
  }) : super(key: key);

  final TransactionType selectedType;
  final TransactionCategoryModel category;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;

    return Positioned.fill(
      bottom: 5,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CategoryTransactionsListDesktop(
                      type: selectedType,
                      category: category,
                    )),
              ),
            );
          },
          child: Container(
            decoration: ShapeDecoration(
              color: primaryColor,
              shape: const StadiumBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 5),
                  const Text('View').boldBgColorText(context),
                  const SizedBox(width: 3),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: bgColor,
                    size: 12,
                    // color: bgColor,
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
