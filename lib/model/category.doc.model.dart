import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryDoc {
  String name;
  int id;
  int index;
  bool active;
  CategoryDoc({
    required this.name,
    required this.id,
    required this.active,
    required this.index,
  });

  static IconData getIcon(String category) {
    switch (category) {
      case "AutoFare":
        return FontAwesomeIcons.taxi;
      case "BusFare":
        return FontAwesomeIcons.taxi;
      case "BottleWater":
        return FontAwesomeIcons.bottleWater;
      case "Food":
        return FontAwesomeIcons.bowlFood;
      default:
        return FontAwesomeIcons.googlePay;
    }
  }
}
