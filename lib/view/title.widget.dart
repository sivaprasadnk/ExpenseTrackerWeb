import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    required this.isHome,
  }) : super(key: key);
  final String title;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 8, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 22,
              fontFamily: 'Rajdhani',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
