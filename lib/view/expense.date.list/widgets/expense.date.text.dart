import 'package:flutter/material.dart';

class ExpenseDateText extends StatelessWidget {
  const ExpenseDateText({
    Key? key,
    required this.date,
    required this.fontColor,
  }) : super(key: key);
  final String date;
  final Color fontColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          date,
          style: TextStyle(
            fontSize: 45, fontWeight: FontWeight.bold, color: fontColor,
            // fontFamily: 'Rajdhani',
          ),
        ),
      ],
    );
  }
}
