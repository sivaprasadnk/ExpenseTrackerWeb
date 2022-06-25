import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:flutter/material.dart';

class AppBarTitleDesktop extends StatelessWidget {
  const AppBarTitleDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final double leftPadding = width > 600 ? width * 0.1 : 12;

    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: 5),
      child: CursorWidget(
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => const HomeScreenDesktop(),
              ),
              (r) => false);
        },
        child: Text(
          'EXPENSE TRACKER',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Rajdhani',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
      ),
    );
  }
}
