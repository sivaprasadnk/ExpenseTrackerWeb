import 'package:flutter/material.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    Key? key,
    required this.title,
    this.fontSize = 18,
  }) : super(key: key);
  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            // // fontFamily: 'Rajdhani',
            color: Colors.black,
            // fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
