import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/drawer/drawer.screen.dart';
import 'package:expense_tracker/view/network_aware_widget.dart';
import 'package:expense_tracker/view/offline.widget.dart';
import 'package:expense_tracker/view/search.screen/search.screen.desktop.dart';
import 'package:expense_tracker/view/title.widget.dart';
import 'package:flutter/material.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({
    Key? key,
    required this.child,
    required this.appBarTitle,
    this.topPadding = 0,
    this.showNetworkStatus = true,
  }) : super(key: key);
  final Widget child;
  final String appBarTitle;
  final double topPadding;
  final bool showNetworkStatus;

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
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
                color: theme.textTheme.bodyMedium!.color,
              ),
            ),
          ),
        ),
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CursorWidget(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
              child: Icon(
                Icons.menu,
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
      endDrawer: const DrawerScreen(),
      body: widget.showNetworkStatus
          ? NetworkAwareWidget(
              offlineChild: const OfflineWidget(),
              onlineChild: SizedBox(
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
            )
          : SizedBox(
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
