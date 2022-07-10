import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  const DividerText({
    Key? key,
    this.fontSize = 20,
  }) : super(key: key);
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    const double height = 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "OR",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
