import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({Key? key, required this.icon, required this.color})
      : super(key: key);
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 30,
      color: color,
    );
  }
}
