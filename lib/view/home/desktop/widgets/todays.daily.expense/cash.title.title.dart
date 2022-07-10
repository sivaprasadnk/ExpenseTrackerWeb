import 'package:flutter/material.dart';

class CashTitleText extends StatelessWidget {
  const CashTitleText({
    Key? key,
    required this.theme,
    this.fontSize = 20,
    this.bottomPadding = 65,
  }) : super(key: key);

  final double fontSize;
  final double bottomPadding;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: bottomPadding,
      left: 10,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Cash ',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
