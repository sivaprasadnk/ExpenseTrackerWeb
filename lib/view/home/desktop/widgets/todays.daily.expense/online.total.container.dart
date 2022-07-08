import 'package:flutter/material.dart';

import 'daily.online.total.text.dart';


class OnlineTotalContainer extends StatelessWidget {
  const OnlineTotalContainer({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 20,
      right: -1,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.scaffoldBackgroundColor,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: const DailyOnlineTotalText(),
        ),
      ),
    );
  }
}
