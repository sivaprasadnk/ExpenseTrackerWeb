import 'package:expense_tracker/common_strings.dart';
import 'package:flutter/material.dart';

class FooterText extends StatelessWidget {
  const FooterText({Key? key, this.fontSize = 20}) : super(key: key);
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      kCopyRightText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color.fromRGBO(0, 24, 88, 1),
      ),
    );
  }
}
