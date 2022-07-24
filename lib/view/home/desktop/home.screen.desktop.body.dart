import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/todays.expenses.title.text.dart';
import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/todays.transactions.list.container.desktop.dart';
import 'package:flutter/material.dart';

import 'widgets/monthly.savings.container/monthly.savings.container.dart';

class HomeScreenDesktopBody extends StatefulWidget {
  const HomeScreenDesktopBody({Key? key, required this.constraints})
      : super(key: key);
  final BoxConstraints constraints;

  @override
  _HomeScreenDesktopBodyState createState() => _HomeScreenDesktopBodyState();
}

class _HomeScreenDesktopBodyState extends State<HomeScreenDesktopBody>
    with TickerProviderStateMixin {
  DateTime now = DateTime.now();

  late AnimationController _controller;

  late Animation<double> _todaysTextContainerOpacity;
  late Animation<Offset> _todaysTextContainerSlide;

  @override
  void initState() {
    super.initState();

    ///
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    ///
    _todaysTextContainerOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    ///
    _todaysTextContainerSlide = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.3, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const opacityDuration = Duration(milliseconds: 900);
    const slideDuration = Duration(milliseconds: 100);
    var time = now.hour;
    var wishText = time < 12
        ? "Good morning !"
        : time == 12
            ? "Good noon !"
            : 'Good evening !';
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Container(
          height: widget.constraints.maxHeight,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: SizedBox(
              width: 430,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wishText,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      AnimatedOpacity(
                        duration: opacityDuration,
                        opacity: _todaysTextContainerOpacity.value,
                        child: AnimatedSlide(
                          duration: slideDuration,
                          offset: _todaysTextContainerSlide.value,
                          child: const MonthlySavingsContainerDesktop(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const TodaysTransactionsTitleText(),
                  const Expanded(
                    child: TodaysTransactionsListContainerDesktop(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
