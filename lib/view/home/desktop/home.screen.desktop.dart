import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.body.dart';
import 'package:expense_tracker/view/home/desktop/widgets/app.bar.title.desktop.dart';
import 'package:expense_tracker/view/home/desktop/widgets/drawer.icon.dart';
import 'package:expense_tracker/view/home/drawer/drawer.screen.dart';
import 'package:expense_tracker/view/search.screen/search.screen.desktop.dart';
import 'package:flutter/material.dart';

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
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawerEnableOpenDragGesture: false,
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppBarTitleDesktop(),
        centerTitle: false,
        actions: [
          CursorWidget(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SearchScreenDesktop()));
            },
            child: Icon(
              Icons.search,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
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
