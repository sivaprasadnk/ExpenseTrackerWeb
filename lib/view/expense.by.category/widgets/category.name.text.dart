import 'package:flutter/material.dart';

class CategoryNameText extends StatelessWidget {
  const CategoryNameText({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 15,
        // fontFamily: 'Rajdhani',
      ),
    );
  }
}
