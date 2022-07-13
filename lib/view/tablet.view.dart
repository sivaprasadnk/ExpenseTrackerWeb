import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/back.arrow.title.widget.dart';
import 'package:expense_tracker/view/home/drawer/drawer.tablet.dart';
import 'package:expense_tracker/view/network_aware_widget.dart';
import 'package:expense_tracker/view/offline.widget.dart';
import 'package:expense_tracker/view/title.widget.dart';
import 'package:flutter/material.dart';

class TabletView extends StatefulWidget {
  const TabletView({
    Key? key,
    required this.child,
    required this.appBarTitle,
    this.isHome = false,
    this.showNetworkStatus = true,
    this.bottomButton = const SizedBox.shrink(),
    this.showSearchIcon = true,
  }) : super(key: key);
  final Widget child;
  final String appBarTitle;
  final bool isHome;
  final bool showNetworkStatus;
  final bool showSearchIcon;
  final Widget bottomButton;
  // final Widgt

  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: widget.bottomButton,
      key: _key,
      appBar: PreferredSize(
        preferredSize: widget.isHome
            ? Size(MediaQuery.of(context).size.width, 50)
            : Size(MediaQuery.of(context).size.width, 55),
        child: AppBar(
          leadingWidth: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: widget.isHome
                ? TitleWidget(
                    title: widget.appBarTitle,
                    isHome: widget.isHome,
                  )
                // ? Padding(
                //   padding: const EdgeInsets.only(left: 13),
                //   child: Text(
                //     'EXPENSE TRACKER',
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontFamily: 'Rajdhani',
                //       fontWeight: FontWeight.bold,
                //       color: theme.textTheme.bodyMedium!.color,
                //     ),
                //   ),
                // )
                : BackArrowTitleWidget(
                    isHome: false,
                    titleWidget: widget.appBarTitle.isNotEmpty
                        ? TitleWidget(
                            title: widget.appBarTitle,
                            isHome: widget.isHome,
                          )
                        : const SizedBox.shrink(),
                  ),
          ),
          actions: [
            if (widget.showSearchIcon)
              CursorWidget(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => const SearchScreenMobile()));
                },
                child: Icon(
                  Icons.search,
                  color: theme.primaryColor,
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
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: const Drawer(
        child: DrawerTablet(),
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
                    // if (widget.appBarTitle.trim().isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                    // else
                    //   const SizedBox(
                    //     height: 8,
                    //   ),
                    // if (widget.appBarTitle.trim().isNotEmpty)
                    //   TitleWidget(
                    //     title: widget.appBarTitle,
                    //     isHome: widget.isHome,
                    //   ),
                    // const Spacer(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: widget.child,
                        ),
                      ),
                    ),
                    // const Spacer(),
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
    );
  }
}
