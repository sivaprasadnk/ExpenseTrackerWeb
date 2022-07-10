import 'package:flutter/material.dart';

class OnlineTitleText extends StatelessWidget {
  const OnlineTitleText({
    Key? key,
    required this.theme,
    this.fontSize = 20,
    this.bottomPadding = 65,
  }) : super(key: key);

  final ThemeData theme;
  final double fontSize;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: bottomPadding,
      right: 10,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          'Online ',
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
