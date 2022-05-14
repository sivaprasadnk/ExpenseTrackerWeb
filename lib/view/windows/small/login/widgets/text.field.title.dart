import 'package:flutter/material.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Rajdhani',
            color: Colors.black,
            // fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
