import 'package:flutter/material.dart';

class DrawerMenuItem extends StatefulWidget {
  const DrawerMenuItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.fontSize = 20,
    this.removeContext = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final bool removeContext;
  final double fontSize;
  @override
  State<DrawerMenuItem> createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<DrawerMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        // if (widget.removeContext) {
        //   Navigator.pop(context);
        // }
        widget.onTap.call();
      },
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
            color: !isHovered ? theme.primaryColor : theme.cardColor,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: !isHovered ? theme.primaryColor : theme.cardColor,
            ),
          ),
        ],
      ),
    );
  }
}
