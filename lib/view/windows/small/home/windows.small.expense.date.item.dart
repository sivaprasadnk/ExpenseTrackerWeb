import 'package:expense_tracker/view/windows/small/expense_details_list/windows.small.expense_details_list.dart';
import 'package:flutter/material.dart';

class WindowsSmallExpenseDateItem extends StatelessWidget {
  const WindowsSmallExpenseDateItem({
    Key? key,
    required this.title,
    required this.total,
  }) : super(key: key);
  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) =>
                    WindowsSmallExpenseDetailsList(title: title)));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          // color: Colors.cyan,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.cyan,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: screenWidth * 0.1),
              SizedBox(
                width: 200,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),

              // const SizedBox(width: 10),
              Text("Rs. $total"),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
