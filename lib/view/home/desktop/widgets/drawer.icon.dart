import 'package:expense_tracker/cursor.widget.dart';
import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CursorWidget(
        onTap: () {
          onTap.call();
        },
        child: Icon(
          Icons.menu,
          color:Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
