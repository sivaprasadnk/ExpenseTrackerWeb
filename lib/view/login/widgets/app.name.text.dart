import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/sample.text.dart';
import 'package:flutter/material.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => const SampleText()));
      },
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          kExpenseTrackerText + ' v2',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
