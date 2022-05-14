import 'package:flutter/material.dart';

class ExpenseDateText extends StatelessWidget {
  const ExpenseDateText({Key? key, required this.date}) : super(key: key);
  final String date;
  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: 'Rajdhani',
      ),
    );
  }
}
