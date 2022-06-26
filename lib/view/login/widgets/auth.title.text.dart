import 'package:flutter/material.dart';



class AuthTitleText extends StatelessWidget {
  const AuthTitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

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
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 24, 88, 1),
            ),
          ),
        ),
      ),
    );
  }
}