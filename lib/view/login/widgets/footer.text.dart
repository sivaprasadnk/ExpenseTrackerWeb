import 'package:expense_tracker/common_strings.dart';
import 'package:flutter/material.dart';

class FooterText extends StatelessWidget {
  const FooterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      kCopyRightText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(0, 24, 88, 1),
      ),
    );
  }
}