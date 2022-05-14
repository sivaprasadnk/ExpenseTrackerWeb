import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/windows/small/expense.by.category.list/expense.by.category.list.screen.dart';
import 'package:expense_tracker/view/windows/small/expense.by.category/widgets/category.icon.dart';
import 'package:expense_tracker/view/windows/small/expense.by.category/widgets/category.name.text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ExpenseByCategoryScreen extends StatelessWidget {
  const ExpenseByCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    var userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kExpenseCategoriesCollection)
              .snapshots(),
          builder: (_, snapshot) {
            return snapshot.connectionState != ConnectionState.done
                ? snapshot.hasData &&
                        (snapshot.data! as QuerySnapshot).docs.length > 0
                    ? GridView.builder(
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (ctx, index) {
                          var doc =
                              (snapshot.data! as QuerySnapshot).docs[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ExpenseByCategoryListScreen(
                                            categoryName: doc.id,
                                          )));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CategoryIcon(
                                    icon: getIcon(doc.id),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CategoryNameText(name: doc.id)
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: screenHeight * 0.5,
                        child: const Center(
                          child: Text(
                            'No Data !',
                            style: TextStyle(
                                // color: Colors.white,
                                ),
                          ),
                        ),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
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
        return Icons.money;
    }
  }
}
