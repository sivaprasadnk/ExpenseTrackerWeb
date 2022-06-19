import 'package:expense_tracker/cursor.widget.dart';
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
    return CursorWidget(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (isHome) {
          Future.delayed(const Duration(seconds: 1)).then((value) {
            Navigator.pop(context);
          });
        } else {
          Navigator.pop(context);
        }
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
                  fontFamily: 'Rajdhani',
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
