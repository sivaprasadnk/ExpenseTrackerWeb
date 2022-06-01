import 'package:flutter/material.dart';

class CategoryName extends StatelessWidget {
  const CategoryName(
      {Key? key, required this.categoryName, required this.textColor})
      : super(key: key);

  final String categoryName;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      categoryName,
      style: TextStyle(
        color: textColor,
      ),
    );
  }
}
