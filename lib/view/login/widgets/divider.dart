import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  const DividerText({
    Key? key,
  }) : super(key: key);

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
          const Text(
            "OR",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
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
