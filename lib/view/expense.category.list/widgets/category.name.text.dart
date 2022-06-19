import 'package:flutter/material.dart';

class CategoryNameText extends StatelessWidget {
  const CategoryNameText(
      {Key? key, required this.name, required this.textColor})
      : super(key: key);
  final String name;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: textColor,
        height: 1,
      ),
    );
  }
}
