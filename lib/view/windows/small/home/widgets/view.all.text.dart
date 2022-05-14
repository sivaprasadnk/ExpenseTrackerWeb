import 'package:expense_tracker/view/windows/small/recent/windows.small.recent.list.dart';
import 'package:flutter/material.dart';

class ViewAllText extends StatelessWidget {
  const ViewAllText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const WindowsSmallRecentList()));
      },
      child: const Text(
        'View All',
        style: TextStyle(
          fontFamily: 'Rajdhani',
          color: Colors.cyan,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
