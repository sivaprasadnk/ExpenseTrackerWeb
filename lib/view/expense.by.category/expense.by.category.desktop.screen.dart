import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/expense.by.category.list/expense.by.category.list.desktop.screen.dart';
import 'package:expense_tracker/view/expense.by.category/widgets/category.icon.dart';
import 'package:expense_tracker/view/expense.by.category/widgets/category.name.text.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ExpenseByCategoryDesktopScreen extends StatelessWidget {
  const ExpenseByCategoryDesktopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    var userId = FirebaseAuth.instance.currentUser!.uid;

    return DesktopView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(userId)
            .collection(kExpenseCategoriesCollection)
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData &&
                      (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? Center(
                      child: SizedBox(
                        width: 450,
                        child: GridView.builder(
                          itemCount:
                              (snapshot.data! as QuerySnapshot).docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 90,
                          ),
                          itemBuilder: (ctx, index) {
                            var doc =
                                (snapshot.data! as QuerySnapshot).docs[index];
                            String categoryName = doc['categoryName'];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            ExpenseByCategoryListDesktopScreen(
                                              categoryName: categoryName,
                                            )));
                              },
                              child: Container(
                                width: 130,
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // padding: EdgeInsets.zero,
                                    // itemExtent: 50,
                                    children: [
                                      // Spacer(),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Center(
                                        child: CategoryIcon(
                                          icon: getIcon(categoryName),
                                        ),
                                      ),

                                      Center(
                                        child: CategoryNameText(
                                            name: categoryName),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const NoExpenseContainerDesktop(
                      title: 'No expense added !',
                    )
              : const Center(
                  child: CircularProgressIndicator(),
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
