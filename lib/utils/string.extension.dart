import 'package:flutter/material.dart';

extension StringExtension on String {
  String initCap() {
    // return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension BoldExtension on Text {
  Text boldBgColorText(BuildContext context) {
    return Text(
      data!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Rajdhani',
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  Text boldBgColorTextWithSize(BuildContext context, double size) {
    return Text(
      data!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Rajdhani',
        fontSize: size,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  Text boldPrimaryColorText(BuildContext context) {
    return Text(
      data!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Rajdhani',
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Text boldPrimaryColorTextWithSize(BuildContext context, double size) {
    return Text(
      data!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
        fontFamily: 'Rajdhani',
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
