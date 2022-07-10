import 'package:expense_tracker/view/add_expense/add.expense.mobile.dart';
import 'package:expense_tracker/view/add_expense/add.expense.windows.small.dart';
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
  // HomeScreenMobile.routeName: (_) => const HomeScreenMobile(),
  SelectThemeDesktopScreen.routeName: (_) => const SelectThemeDesktopScreen(),
  SelectThemeMobileScreen.routeName: (_) => const SelectThemeMobileScreen(),
  // LoginScreenDesktop.routeName: (_) => const LoginScreenDesktop(),
  AddExpenseScreenDesktop.routeName: (_) => const AddExpenseScreenDesktop(),
  AddExpenseMobile.routeName: (_) => const AddExpenseMobile(),
  SelectCategoryScreenMobile.routeName: (_) =>
      const SelectCategoryScreenMobile(),
  // TodaysExpenseListMobileScreen.routeName: (_) =>
  //     const TodaysExpenseListMobileScreen(),
  ExpenseMonthsDesktop.routeName: ((context) => const ExpenseMonthsDesktop()),
};
