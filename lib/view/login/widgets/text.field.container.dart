import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key? key,
    required this.child,
    this.width = 300,
    this.margin= const EdgeInsets.symmetric(horizontal: 10),
  }) : super(key: key);
  final Widget child;
  final double width;
  final EdgeInsetsGeometry margin;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: child,
          ),
        ),
      ),
    );
  }
}
