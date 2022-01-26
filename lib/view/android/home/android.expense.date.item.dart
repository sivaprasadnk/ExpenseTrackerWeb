import 'package:expense_tracker/view/android/expense_details/android.expense_details.dart';
import 'package:flutter/material.dart';

class AndroidExpenseDateItem extends StatelessWidget {
  const AndroidExpenseDateItem({
    Key? key,
    required this.title,
    required this.total,
  }) : super(key: key);
  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => AndroidExpenseDetails(title: title)));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.cyan,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              const SizedBox(width: 10),
              Text("Rs. $total"),
            ],
          ),
        ),
      ),
    );
  }
}
