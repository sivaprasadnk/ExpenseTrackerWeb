import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.by.category.list/expense.by.category.list.desktop.screen.dart';
import 'package:expense_tracker/view/expense.category.list/widgets/category.icon.dart';
import 'package:expense_tracker/view/expense.category.list/widgets/category.name.text.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.amount.text.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class ExpenseCategoryListDesktopScreen2 extends StatefulWidget {
  const ExpenseCategoryListDesktopScreen2({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryListDesktopScreen2> createState() =>
      _ExpenseCategoryListDesktopScreen2State();
}

class _ExpenseCategoryListDesktopScreen2State
    extends State<ExpenseCategoryListDesktopScreen2> {
  ///
  List<bool> hoveredStatusList = List<bool>.generate(31, (index) => false);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return DesktopView(
      isHome: false,
      appBarTitle: 'Select Category',
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseCategoriesCollection)
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.hasData
              ? (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05) +
                          EdgeInsets.only(bottom: 20, left: width * 0.05),
                      child: Center(
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          alignment: WrapAlignment.start,
                          children: (snapshot.data! as QuerySnapshot).docs.map(
                            (doc) {
                              String categoryName = doc['categoryName'];
                              int categoryId = doc['categoryId'];
                              int totalAmount = doc['totalAmount'];
                              return InkWell(
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                onHover: (val) {
                                  setState(() {
                                    hoveredStatusList[categoryId] = val;
                                  });
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ExpenseByCategoryListDesktopScreen(
                                        categoryName: categoryName,
                                        totalAmount: totalAmount,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 38),
                                      width: 250,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: !hoveredStatusList[categoryId]
                                            ? bgColor
                                            : primaryColor,
                                        border: Border.all(
                                          color: primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CategoryNameText(
                                            name: categoryName,
                                            textColor:
                                                hoveredStatusList[categoryId]
                                                    ? bgColor
                                                    : primaryColor,
                                          ),
                                          const SizedBox(height: 8),
                                          ExpenseAmountText(
                                            amount: totalAmount.toString(),
                                            textColor:
                                                hoveredStatusList[categoryId]
                                                    ? bgColor
                                                    : primaryColor,
                                            fontSize: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      top: 5,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: bgColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: primaryColor,
                                            ),
                                          ),
                                          child: CategoryIcon(
                                            icon: getIcon(categoryName),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    )
                  : const NoExpenseContainerDesktop(
                      title: 'Categories of expenses added will list here.',
                    )
              : Center(
                  child: NeumorphicLoader(
                    size: 75,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                );
        },
      ),
    );
  }

  IconData getIcon(String category) {
    switch (category) {
      case "AutoFare":
        return FontAwesomeIcons.taxi;
      case "BusFare":
        return FontAwesomeIcons.taxi;
      case "BottleWater":
        return FontAwesomeIcons.bottleWater;
      case "Food":
        return FontAwesomeIcons.bowlFood;
      default:
        return FontAwesomeIcons.googlePay;
    }
  }
}
