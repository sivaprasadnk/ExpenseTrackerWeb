import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/back.arrow.title.widget.dart';
import 'package:expense_tracker/view/home/drawer/drawer.screen.dart';
import 'package:expense_tracker/view/network_aware_widget.dart';
import 'package:expense_tracker/view/offline.widget.dart';
import 'package:expense_tracker/view/title.widget.dart';
import 'package:flutter/material.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({
    Key? key,
    required this.child,
    required this.appBarTitle,
    required this.isHome,
    this.topPadding = 0,
    this.showNetworkStatus = true,
  }) : super(key: key);
  final Widget child;
  final String appBarTitle;
  final double topPadding;
  final bool showNetworkStatus;
  final bool isHome;

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final double leftPadding = width > 600 ? width * 0.1 : 12;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawerEnableOpenDragGesture: false,
      key: _key,
      appBar: AppBar(
        leadingWidth: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        title: BackArrowTitleWidget(
          isHome: widget.isHome,
          titleWidget: const SizedBox.shrink(),
        ),
        centerTitle: false,
        actions: [
          CursorWidget(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => const SearchScreenDesktop()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.search,
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
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
                        SizedBox(width: leftPadding),
                        if (widget.appBarTitle.trim().isNotEmpty)
                          TitleWidget(
                            title: widget.appBarTitle,
                            isHome: widget.isHome,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: widget.topPadding,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: widget.child,
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
                      TitleWidget(
                        title: widget.appBarTitle,
                        isHome: widget.isHome,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widget.topPadding,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
