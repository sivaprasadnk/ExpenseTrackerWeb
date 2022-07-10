import 'package:flutter/material.dart';

class ExpenseModeText extends StatelessWidget {
  const ExpenseModeText({
    Key? key,
    required this.mode,
    this.fontSize = 18,
    this.rightPadding = 30,
  }) : super(key: key);
  final String mode;
  final double fontSize;
  final double rightPadding;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 25,
      right: rightPadding,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          'Mode : $mode',
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
