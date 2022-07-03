import 'package:expense_tracker/cursor.widget.dart';
import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CursorWidget(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
