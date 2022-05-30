import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/category.doc.model.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';
import 'package:provider/provider.dart';

class SelectCategoryScreenDesktop extends StatefulWidget {
  const SelectCategoryScreenDesktop({Key? key}) : super(key: key);

  @override
  State<SelectCategoryScreenDesktop> createState() =>
      _SelectCategoryScreenDesktopState();
}

class _SelectCategoryScreenDesktopState
    extends State<SelectCategoryScreenDesktop> {
  int selectedIndex = 100;
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  @override
  void initState() {
    stream = FirebaseFirestore.instance
        .collection(kExpenseCategoriesCollection)
        .orderBy('index')
        .where('active', isEqualTo: true)
        .snapshots();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return DesktopView(
      appBarTitle: 'Select Category',
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.7,
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        itemBuilder: (_, index) {
                          var doc =
                              (snapshot.data! as QuerySnapshot).docs[index];
                          CategoryDoc model = CategoryDoc(
                            name: doc['name'].toString(),
                            id: doc['id'] as int,
                            active: doc['active'] as bool,
                            index: doc['index'] as int,
                          );
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context, model);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: index == selectedIndex
                                      ? primaryColor
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CategoryDoc.getIcon(doc.id),
                                    color: index != selectedIndex
                                        ? primaryColor
                                        : theme
                                            .themeData.scaffoldBackgroundColor,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    model.name,
                                    style: TextStyle(
                                      color: index != selectedIndex
                                          ? primaryColor
                                          : theme.themeData
                                              .scaffoldBackgroundColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: NeumorphicLoader(
                          size: 75,
                          borderColor: Theme.of(context).primaryColor,
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
