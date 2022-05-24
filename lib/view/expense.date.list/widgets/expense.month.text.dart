import 'package:flutter/material.dart';

class ExpenseMonthText extends StatelessWidget {
  const ExpenseMonthText({Key? key, required this.month}) : super(key: key);
  final String month;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          month,
          style: TextStyle(
            fontSize: 15,
            // fontFamily: 'Rajdhani',
          ),
        ),
      ],
    );
  }
}
