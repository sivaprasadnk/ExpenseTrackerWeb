import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/drawer/drawer.screen.dart';
import 'package:expense_tracker/view/title.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({
    Key? key,
    required this.child,
    required this.appBarTitle,
    this.topPadding = 0,
  }) : super(key: key);
  final Widget child;
  final String appBarTitle;
  final double topPadding;
  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
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
        // titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: CursorWidget(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreenDesktop.routeName, (r) => false);
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
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CursorWidget(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
      endDrawer: const Drawer(
        child: DrawerScreen(),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TitleWidget(title: widget.appBarTitle),
              ],
            ),
            SizedBox(
              height: widget.topPadding,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: SizedBox(
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
