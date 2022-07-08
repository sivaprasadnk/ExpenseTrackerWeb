import 'package:flutter/material.dart';




class CashTitleText extends StatelessWidget {
  const CashTitleText({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 65,
      left: 10,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Cash ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}