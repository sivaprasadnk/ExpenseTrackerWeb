import 'package:flutter/material.dart';

class CursorWidget extends StatefulWidget {
  const CursorWidget({
    Key? key,
    required this.child,
    this.isButton = false,
    this.hoverColor = Colors.transparent,
    this.bgColor = Colors.transparent,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final bool isButton;
  final Color hoverColor;
  final Color bgColor;
  final Function? onTap;
  @override
  State<CursorWidget> createState() => _CursorWidgetState();
}

class _CursorWidgetState extends State<CursorWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // final ThemeNotifier theme =
    //     Provider.of<ThemeNotifier>(context, listen: true);
    // var primaryColor = theme.themeData.primaryColor;
    return InkWell(
      hoverColor: widget.hoverColor,
      mouseCursor: SystemMouseCursors.click,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!.call();
        }
      },
      onHover: (val) {
        setState(() {
          isHovered = val;
        });
      },
      child: widget.isButton
          ? Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isHovered
                    ? [
                        const BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10.0,
                        )
                      ]
                    : [
                        const BoxShadow(
                          color: Colors.transparent,
                          blurRadius: 0.0,
                        )
                      ],
              ),
              child: widget.child,
            )
          : widget.child,
    );
  }
}
