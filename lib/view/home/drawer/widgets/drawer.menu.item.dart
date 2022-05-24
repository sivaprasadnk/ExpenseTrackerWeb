import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenuItem extends StatefulWidget {
  const DrawerMenuItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String title;

  @override
  State<DrawerMenuItem> createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<DrawerMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      onHover: (val) {
        setState(() {
          isHovered = val;
        });
      },
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Icon(
            widget.icon,
            color: !isHovered
                ? Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black
                : theme.themeData.cardColor,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              color: !isHovered
                  ? Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black
                  : theme.themeData.cardColor,
            ),
          ),
        ],
      ),
    );
  }
}
