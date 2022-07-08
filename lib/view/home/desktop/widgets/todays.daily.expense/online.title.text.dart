import 'package:flutter/material.dart';



class OnlineTitleText extends StatelessWidget {
  const OnlineTitleText({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 65,
      right: 10,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          'Online ',
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
