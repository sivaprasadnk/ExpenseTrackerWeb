import 'package:auto_animated/auto_animated.dart';
import 'package:expense_tracker/model/recent.expense.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/expense.list.item.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentExpensesListContainerMobile extends StatefulWidget {
  const RecentExpensesListContainerMobile({Key? key}) : super(key: key);

  @override
  _RecentExpensesListContainerMobileState createState() =>
      _RecentExpensesListContainerMobileState();
}

class _RecentExpensesListContainerMobileState
    extends State<RecentExpensesListContainerMobile> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return SizedBox(
      height: screenHeight * 0.4,
      child: Consumer<HomeProvider>(
        builder: (_, provider, __) {
          return provider.recentExpensesList.isNotEmpty
              ? LiveList(
                  visibleFraction: 0.8,
                  physics: const BouncingScrollPhysics(),
                  showItemDuration: const Duration(milliseconds: 900),
                  padding: const EdgeInsets.only(left: 1, top: 10),
                  showItemInterval: const Duration(milliseconds: 50),
                  itemCount: provider.recentExpensesList.length,
                  itemBuilder: animationItemBuilder(
                    (index) {
                      RecentExpense doc = provider.recentExpensesList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ExpenseListItem(
                          expense: doc,
                        ),
                      );
                    },
                  ),
                )
              : const NoExpenseContainerMobile(
                  title: 'Recently added expenses will list here.',
                );
        },
      ),
    );
  }

  Widget Function(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) animationItemBuilder(
    Widget Function(int index) child, {
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child(index),
              ),
            ),
          );
}
