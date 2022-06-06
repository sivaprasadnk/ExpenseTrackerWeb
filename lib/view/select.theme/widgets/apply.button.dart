import 'package:expense_tracker/cursor.widget.dart';
import 'package:flutter/material.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CursorWidget(
      buttonHeight: 50,
      isButton: true,
      bgColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Text(
          'Apply',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
