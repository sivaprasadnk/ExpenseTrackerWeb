import 'package:flutter/material.dart';

class ExpenseTitleText extends StatelessWidget {
  const ExpenseTitleText({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 25,
        // fontWeight: FontWeight.bold,
        fontFamily: 'Rajdhani',
      ),
    );
  }
}
