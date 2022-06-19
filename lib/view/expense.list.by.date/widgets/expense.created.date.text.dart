import 'package:flutter/material.dart';

class ExpenseCreatedDateText extends StatelessWidget {
  const ExpenseCreatedDateText({Key? key, required this.createdDate})
      : super(key: key);
  final String createdDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.access_time,
          size: 12,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          createdDate,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
