import 'package:expense_tracker/view/add.transaction/add.transaction.desktop.dart';
import 'package:flutter/material.dart';

class AddTransactionButton extends StatelessWidget {
  const AddTransactionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => const AddTransactionScreenDesktop())));
      },
      child: Container(
        width: 75,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.add,
                size: 13,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
