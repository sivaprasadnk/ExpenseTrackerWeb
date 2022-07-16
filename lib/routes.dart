
import 'package:expense_tracker/view/add.transaction/add.transaction.desktop.dart';
import 'package:expense_tracker/view/expense.months/expense.months.desktop.dart';
import 'package:expense_tracker/view/home/home.screen.dart';
import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:expense_tracker/view/select.category/select.category.screen.mobile.dart';
import 'package:expense_tracker/view/select.theme/select.theme.desktop.screen.dart';
import 'package:expense_tracker/view/select.theme/select.theme.mobile.screen.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  LoginScreen.routeName: (_) => const LoginScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
  AddTransactionScreenDesktop.routeName: (context) =>
      const AddTransactionScreenDesktop(),
  // HomeScreenMobile.routeName: (_) => const HomeScreenMobile(),
  SelectThemeDesktopScreen.routeName: (_) => const SelectThemeDesktopScreen(),
  SelectThemeMobileScreen.routeName: (_) => const SelectThemeMobileScreen(),
  // LoginScreenDesktop.routeName: (_) => const LoginScreenDesktop(),
  SelectCategoryScreenMobile.routeName: (_) =>
      const SelectCategoryScreenMobile(),
  // TodaysExpenseListMobileScreen.routeName: (_) =>
  //     const TodaysExpenseListMobileScreen(),
  ExpenseMonthsDesktop.routeName: ((context) => const ExpenseMonthsDesktop()),
};
