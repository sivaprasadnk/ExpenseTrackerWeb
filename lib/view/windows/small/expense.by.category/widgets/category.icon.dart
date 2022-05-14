import 'package:flutter/widgets.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(icon),
    );
  }
}
