import 'package:flutter/material.dart';

class CursorWidget extends StatefulWidget {
  const CursorWidget({
    Key? key,
    required this.child,
    this.isButton = false,
    this.hoverColor = Colors.transparent,
    this.bgColor = Colors.transparent,
    this.onTap,
    this.buttonHeight,
    this.buttonWidth,
    this.borderColor,
    this.horizontalMargin= 10,
  }) : super(key: key);

  final Widget child;
  final bool isButton;
  final Color hoverColor;
  final Color bgColor;
  final Function? onTap;
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? borderColor;
  final double horizontalMargin;
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
              width: widget.buttonWidth ?? double.infinity,
              height: widget.buttonHeight ?? 40,
              margin:  EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
              decoration: BoxDecoration(
                color: widget.bgColor,
                border:
                    Border.all(color: widget.borderColor ?? Colors.transparent),
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
