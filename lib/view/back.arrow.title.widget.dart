import 'package:flutter/material.dart';

class BackArrowTitleWidget extends StatelessWidget {
  const BackArrowTitleWidget({
    Key? key,
    required this.isHome,
    required this.titleWidget,
  }) : super(key: key);
  final bool isHome;

  final Widget titleWidget;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return InkWell(
      hoverColor: Colors.transparent,
      mouseCursor: SystemMouseCursors.click,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
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
      child: Row(
        children: [
          Container(
            height: 50,
            width: 75,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          titleWidget,
        ],
      ),
    );
  }
}
