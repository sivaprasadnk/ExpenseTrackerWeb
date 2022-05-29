import 'package:expense_tracker/view/add_expense/add.expense.mobile.dart';
import 'package:expense_tracker/view/add_expense/add.expense.windows.small.dart';
import 'package:expense_tracker/view/add_expense/select.category.screen.mobile.dart';
import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
import 'package:expense_tracker/view/home/mobile/home.screen.mobile.dart';
import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:expense_tracker/view/select.theme/select.theme.desktop.screen.dart';
import 'package:expense_tracker/view/select.theme/select.theme.mobile.screen.dart';
import 'package:expense_tracker/view/todays.expense.list/todays.expense.list.mobile.screen.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  HomeScreenDesktop.routeName: (_) => const HomeScreenDesktop(),
  HomeScreenMobile.routeName: (_) => const HomeScreenMobile(),
  SelectThemeDesktopScreen.routeName: (_) => const SelectThemeDesktopScreen(),
  SelectThemeMobileScreen.routeName: (_) => const SelectThemeMobileScreen(),
  LoginScreen.routeName: (_) => const LoginScreen(),
  AddExpenseScreenDesktop.routeName: (_) => const AddExpenseScreenDesktop(),
  AddExpenseMobile.routeName: (_) => const AddExpenseMobile(),
  SelectCategoryScreenMobile.routeName: (_) =>
      const SelectCategoryScreenMobile(),
  TodaysExpenseListMobileScreen.routeName: (_) =>
      const TodaysExpenseListMobileScreen()
};
