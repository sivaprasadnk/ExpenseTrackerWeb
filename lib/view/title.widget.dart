import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context, listen: false).themeData;
    return CursorWidget(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                color: theme.scaffoldBackgroundColor,
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  color: theme.scaffoldBackgroundColor,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
