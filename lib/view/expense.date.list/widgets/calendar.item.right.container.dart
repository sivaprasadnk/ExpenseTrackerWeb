import 'package:flutter/material.dart';

class CalendarItemRightContainer extends StatelessWidget {
  const CalendarItemRightContainer({
    Key? key,
    required this.bgColor,
    required this.primaryColor,
    this.rightPosition = 45,
  }) : super(key: key);

  final Color bgColor;
  final Color primaryColor;
  final double rightPosition;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      right: rightPosition,
      child: Align(
        alignment: Alignment.topRight,
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
