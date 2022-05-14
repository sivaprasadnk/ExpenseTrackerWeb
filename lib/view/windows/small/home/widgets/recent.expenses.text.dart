import 'package:flutter/material.dart';

class RecentExpensesText extends StatelessWidget {
  const RecentExpensesText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Recent Expenses',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Rajdhani',
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
