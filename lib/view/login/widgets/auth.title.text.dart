import 'package:flutter/material.dart';

class AuthTitleText extends StatelessWidget {
  const AuthTitleText({
    Key? key,
    this.fontSize = 20,
    required this.title,
  }) : super(key: key);

  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(0, 24, 88, 1),
            ),
          ),
        ),
      ),
    );
  }
}
