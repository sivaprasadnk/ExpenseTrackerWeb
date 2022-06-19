import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/category.doc.model.dart';
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

class SelectCategoryScreenDesktop2 extends StatefulWidget {
  const SelectCategoryScreenDesktop2({Key? key}) : super(key: key);

  @override
  State<SelectCategoryScreenDesktop2> createState() =>
      _SelectCategoryScreenDesktop2State();
}

class _SelectCategoryScreenDesktop2State
    extends State<SelectCategoryScreenDesktop2> {
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
            .collection(kExpenseCategoriesCollection)
            .snapshots(),
        builder: (_, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData &&
                      (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1) +
                          const EdgeInsets.only(bottom: 20),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: (snapshot.data! as QuerySnapshot).docs.map(
                          (doc) {
                              CategoryDoc model = CategoryDoc.fromJson(doc);
                            return InkWell(
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              onHover: (val) {
                                setState(() {
                                  hoveredStatusList[model.id] = val;
                                });
                              },
                              onTap: () {
                                Navigator.pop(context, model);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 38),
                                    width: 250,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: !hoveredStatusList[model.id]
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
                                          name: model.name,
                                          textColor:
                                              hoveredStatusList[model.id]
                                                  ? bgColor
                                                  : primaryColor,
                                        ),
                                        const SizedBox(height: 8),
                                      
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
                                          icon: getIcon(model.name),
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
                    )
                  // ? GridView.builder(
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  //     // itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //       // maxCrossAxisExtent: 150,
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 20,
                  //       mainAxisSpacing: 20,
                  //       mainAxisExtent: 150,
                  //       // childAspectRatio: 2,
                  //     ),
                  //     itemBuilder: (context, index) {
                  //       var doc = (snapshot.data! as QuerySnapshot).docs[index];
                  //       String categoryName = doc['categoryName'];
                  //       return GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (_) =>
                  //                   ExpenseByCategoryListDesktopScreen(
                  //                 categoryName: categoryName,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         child: Container(
                  //           width: 100,
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: primaryColor,
                  //             ),
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Center(
                  //                 child: CategoryIcon(
                  //                   icon: getIcon(categoryName),
                  //                 ),
                  //               ),
                  //               Center(
                  //                 child: CategoryNameText(name: categoryName),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   )
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
