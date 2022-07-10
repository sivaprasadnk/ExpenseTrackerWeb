import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({
    Key? key,
    required this.desktopScreen,
    required this.tabletScreen,
    required this.mobileScreen,
  }) : super(key: key);

  final Widget mobileScreen;
  final Widget tabletScreen;
  final Widget desktopScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth > 1200) {
          return desktopScreen;
        } else if (constraints.maxWidth > 510) {
          return tabletScreen;
        } else {
          return mobileScreen;
        }
      }),
    );
  }
}
