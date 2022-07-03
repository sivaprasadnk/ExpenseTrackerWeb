import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 30,
      color: Theme.of(context).primaryColor,
    );
  }
}
