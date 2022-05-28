import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.body.dart';
import 'package:expense_tracker/view/home/desktop/widgets/app.bar.title.desktop.dart';
import 'package:expense_tracker/view/home/desktop/widgets/drawer.icon.dart';
import 'package:expense_tracker/view/home/drawer/drawer.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({Key? key}) : super(key: key);
  static const routeName = '/HomeScreen';
  @override
  _HomeScreenDesktopState createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);

    return Scaffold(
      backgroundColor: theme.themeData.scaffoldBackgroundColor,
      drawerEnableOpenDragGesture: false,
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppBarTitleDesktop(),
        centerTitle: false,
        actions: [
          DrawerIcon(onTap: () {
            _key.currentState!.openEndDrawer();
          }),
        ],
      ),
      endDrawer: const DrawerScreen(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return HomeScreenDesktopBody(constraints: constraints);
        },
      ),
    );
  }
}
