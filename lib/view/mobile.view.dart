import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/home/drawer/drawer.screen.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:expense_tracker/view/network_aware_widget.dart';
import 'package:expense_tracker/view/offline.widget.dart';
import 'package:expense_tracker/view/search.screen/search.screen.mobile.dart';
import 'package:expense_tracker/view/title.widget.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class MobileView extends StatefulWidget {
  const MobileView({
    Key? key,
    required this.child,
    this.isHome = false,
    required this.appBarTitle,
    this.showNetworkStatus = true,
    this.showSearchIcon = true,
  }) : super(key: key);
  final Widget child;
  final String appBarTitle;
  final bool isHome;
  final bool showNetworkStatus;
  final bool showSearchIcon;

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
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
        leading: const SizedBox.shrink(),
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leadingWidth: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: widget.isHome
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreenMobile.routeName, (r) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Text(
                      'EXPENSE TRACKER',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rajdhani',
                        color: theme.textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                )
              : TitleWidget(title: widget.appBarTitle, isHome: widget.isHome,),
        ),
        centerTitle: false,
        actions: [
          if (widget.showSearchIcon)
            CursorWidget(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchScreenMobile()));
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
            child: GestureDetector(
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
      endDrawer: const Drawer(
        child: DrawerScreen(),
      ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: widget.child,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: widget.child,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
    );
  }
}
