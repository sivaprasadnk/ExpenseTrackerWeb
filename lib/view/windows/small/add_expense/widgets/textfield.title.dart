import 'package:flutter/material.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$title ",
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'Rajdhani',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
