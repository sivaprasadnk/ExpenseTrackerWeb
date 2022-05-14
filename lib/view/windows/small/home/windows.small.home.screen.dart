import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/windows/small/home/drawer/drawer.screen.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/add.expense.button.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/recent.expenses.list.container.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/recent.expenses.text.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/sign.out.icon.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/todays.total.expense.container.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/view.expense.by.category.container.dart';
import 'package:expense_tracker/view/windows/small/home/widgets/view.expenses.by.date.container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WindowsSmallHome extends StatefulWidget {
  const WindowsSmallHome({Key? key}) : super(key: key);
  static const routeName = '/Home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WindowsSmallHome> {
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
        leading: GestureDetector(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          SignOutIcon(),
        ],
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Container(
            height: constraints.maxHeight,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TodaysTotalExpenseContainer(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        ViewExpensesByDateContainer(
                          maxWidth: constraints.maxWidth,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ViewExpenseByCategoryContainer(
                            maxWidth: constraints.maxWidth),
                        const SizedBox(
                          width: 20,
                        ),
                        AddExpenseButton(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RecentExpensesText(),
                  RecentExpensesListContainer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
