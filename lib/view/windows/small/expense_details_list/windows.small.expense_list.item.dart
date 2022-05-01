import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/view/windows/small/expense_details/windows.small.expense.details.dart';
import 'package:flutter/material.dart';

class WindowsSmallExpenseItem extends StatelessWidget {
  const WindowsSmallExpenseItem({
    Key? key,
    required this.title,
    required this.amount,
    required this.docId,
    required this.date,
  }) : super(key: key);
  final String title;
  final String amount;
  final String docId;
  final String date;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => WindowsSmallExpenseDetails(
                        title: title,
                        date: date,
                        docId: docId,
                      )));
        },
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.cyan,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: screenWidth * 0.2),
              Text(title),
              const SizedBox(width: 10),
              Text('Rs. $amount'),
              SizedBox(width: screenWidth * 0.2),
              IconButton(
                onPressed: () {
                  deleteExpense(context);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  deleteExpense(BuildContext context) async {
    await UserRepo().deleteExpense(docId, date).then((response) async {
      debugPrint('.. @@ here  2');
      if (response.status == ResponseStatus.error) {
        await showOkAlertDialog(
          context: context,
          title: 'Alert',
          message: response.message,
        );
      } else {
        Navigator.pop(context);
      }
    });
  }
}
