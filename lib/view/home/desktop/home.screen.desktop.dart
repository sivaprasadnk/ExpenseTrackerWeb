import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.body.dart';
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
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: CursorWidget(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const HomeScreenDesktop(),
                  ),
                  (r) => false);
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
      body: LayoutBuilder(
        builder: (_, constraints) {
          // debugPrint('.. width : ${constraints.maxWidth}');
          return HomeScreenDesktopBody(constraints: constraints);
        },
      ),
    );
  }
}
