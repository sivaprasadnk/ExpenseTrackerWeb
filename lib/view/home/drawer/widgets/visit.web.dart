import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitWeb extends StatelessWidget {
  const VisitWeb({Key? key, this.fontSize = 20}) : super(key: key);
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () async {
        await launchUrl(
            Uri.parse('https://expensetrackerapp-9617f.web.app/#/'));
      },
      icon: Icons.launch,
      fontSize: fontSize,
      title: 'Visit Website',
    );
  }
}
