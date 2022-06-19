

import 'package:flutter/material.dart';

class CalendarItemLeftContainer extends StatelessWidget {
  const CalendarItemLeftContainer({
    Key? key,
    required this.bgColor,
    required this.primaryColor,
  }) : super(key: key);

  final Color bgColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: 30,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: 23,
          width: 10,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            border: Border.all(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
