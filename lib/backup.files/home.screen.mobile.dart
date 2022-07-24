import 'package:expense_tracker/view/home/desktop/widgets/recent.expense.list/todays.expenses.title.text.dart';
import 'package:expense_tracker/view/home/mobile/widgets/add.expense.button.mobile.dart';
import 'package:expense_tracker/view/home/mobile/widgets/view.expense.by.category.container.mobile.dart';
import 'package:expense_tracker/view/home/mobile/widgets/view.expenses.by.date.container.mobile.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:flutter/material.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({
    Key? key,
  }) : super(key: key);
  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile>
    with TickerProviderStateMixin {
  DateTime now = DateTime.now();

  late AnimationController _controller;
  late Animation<double> _todaysTextContainerOpacity;
  late Animation<double> _expenseByDateOpacity;
  late Animation<double> _expenseByCategoryOpacity;
  late Animation<double> _addExpenseOpacity;
  late Animation<Offset> _todaysTextContainerSlide;
  late Animation<Offset> _expenseByDateSlide;
  late Animation<Offset> _expenseByCategorySlide;
  late Animation<Offset> _addExpenseSlide;

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

    ///
    _expenseByDateOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.4, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
    _expenseByDateSlide = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.5, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _expenseByCategoryOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.6, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
    _expenseByCategorySlide = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.7, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _addExpenseOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 0.8, curve: Curves.linear),
      ),
    );
    _addExpenseSlide = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 0.9, curve: Curves.easeIn),
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    var time = now.hour;

    var wishText = time < 12
        ? "Good morning !"
        : time == 12
            ? "Good noon !"
            : 'Good evening !';
    return MobileView(
      isHome: true,
      appBarTitle: wishText,
      showSearchIcon: true,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Spacer(),

                const SizedBox(
                  height: 5,
                ),
                // const Spacer(),

                AnimatedOpacity(
                  duration: opacityDuration,
                  opacity: _todaysTextContainerOpacity.value,
                  child: AnimatedSlide(
                    duration: slideDuration,
                    offset: _todaysTextContainerSlide.value,
                    child: const SizedBox(),
                    // child: const TodaysTotalExpenseContainerMobile(
                    //   height: 155,
                    // ),
                  ),
                ),
                // const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  // width: 430,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedOpacity(
                        duration: opacityDuration,
                        opacity: _expenseByDateOpacity.value,
                        child: AnimatedSlide(
                          duration: slideDuration,
                          offset: _expenseByDateSlide.value,
                          child: ViewExpensesByDateContainerMobile(
                            width: width / 3 - 20,
                            height: 150,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AnimatedOpacity(
                        duration: opacityDuration,
                        opacity: _expenseByCategoryOpacity.value,
                        child: AnimatedSlide(
                          duration: slideDuration,
                          offset: _expenseByCategorySlide.value,
                          child: ViewExpenseByCategoryContainerMobile(
                            width: width / 3 - 20,
                            height: 150,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AnimatedOpacity(
                        duration: opacityDuration,
                        opacity: _addExpenseOpacity.value,
                        child: AnimatedSlide(
                          duration: slideDuration,
                          offset: _addExpenseSlide.value,
                          child: const AddExpenseButtonMobile(
                            height: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Spacer(),

                const TodaysTransactionsTitleText(), // const Spacer(),
                // const Spacer()
              ],
            ),
          );
        },
      ),
    );
  }
}
