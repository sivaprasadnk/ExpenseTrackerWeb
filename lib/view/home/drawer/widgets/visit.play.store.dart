import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitPlayStore extends StatelessWidget {
  const VisitPlayStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
        onTap: () {
          launchUrl(Uri.parse(kPlayStoreLink));
        },
        icon: Icons.launch,
        title: 'PlayStore link');
  }
}
