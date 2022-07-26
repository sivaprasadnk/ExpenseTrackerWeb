import 'package:flutter/material.dart';

class TotalSavingsTitleText extends StatelessWidget {
  const TotalSavingsTitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, bottom: 13),
      child: Text(
        'Total Savings',
        style: TextStyle(
          height: 1.2,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
