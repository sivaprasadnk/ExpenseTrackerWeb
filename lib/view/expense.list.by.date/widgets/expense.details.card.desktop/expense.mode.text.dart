import 'package:flutter/material.dart';

class ExpenseModeText extends StatelessWidget {
  const ExpenseModeText({Key? key, required this.mode}) : super(key: key);
  final String mode;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 25,
      right: 30,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          'Mode : $mode',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
