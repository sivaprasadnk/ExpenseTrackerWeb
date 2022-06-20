import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/expense.by.category.list/expense.by.category.list.mobile.screen.dart';
import 'package:expense_tracker/view/expense.category.list/widgets/category.icon.dart';
import 'package:expense_tracker/view/expense.category.list/widgets/category.name.text.dart';
import 'package:expense_tracker/view/expense.date.list/widgets/expense.amount.text.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class ExpenseCategoryListMobileScreen extends StatelessWidget {
  const ExpenseCategoryListMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    return MobileView(
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
                  ? Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 15) +
                              const EdgeInsets.only(bottom: 20),
                          child: Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children:
                                (snapshot.data! as QuerySnapshot).docs.map(
                              (doc) {
                                String categoryName = doc['categoryName'];
                                                          int totalAmount = doc['totalAmount'];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ExpenseByCategoryListMobileScreen(
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
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: CategoryNameText(
                                                name: categoryName,
                                                textColor: primaryColor,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            ExpenseAmountText(
                                              amount:
                                                 totalAmount.toString(),
                                              textColor: primaryColor,
                                              fontSize: 25,
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
                                              color:
                                                  theme.scaffoldBackgroundColor,
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
                      ),
                    )
                  : const NoExpenseContainerMobile(
                      title: 'Categories of expenses added will list here !',
                    )
              : Center(
                  child: NeumorphicLoader(
                    size: 75,
                    borderColor: primaryColor,
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
