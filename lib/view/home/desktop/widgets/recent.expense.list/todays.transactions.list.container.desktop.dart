import 'package:auto_animated/auto_animated.dart';
import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/expense.list.item.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodaysTransactionsListContainerDesktop extends StatefulWidget {
  const TodaysTransactionsListContainerDesktop({Key? key}) : super(key: key);

  @override
  _TodaysTransactionsListContainerDesktopState createState() =>
      _TodaysTransactionsListContainerDesktopState();
}

class _TodaysTransactionsListContainerDesktopState
    extends State<TodaysTransactionsListContainerDesktop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<HomeProvider>(
        builder: (_, provider, __) {
          return provider.recentTransactionsList.isNotEmpty
              ? LiveList(
                  visibleFraction: 0.8,
                  showItemDuration: const Duration(milliseconds: 900),
                  padding: const EdgeInsets.only(left: 1, top: 10),
                  showItemInterval: const Duration(milliseconds: 50),
                  itemCount: provider.recentTransactionsList.length,
                  itemBuilder: animationItemBuilder(
                    (index) {
                      TransactionModel doc =
                          provider.recentTransactionsList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TransactionListItem(
                          transaction: doc,
                        ),
                      );
                    },
                  ),
                )
              : const NoTransactionsContainerDesktop(
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
