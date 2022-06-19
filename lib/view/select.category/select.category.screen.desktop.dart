import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/category.doc.model.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:expense_tracker/view/select.category/widgets/category.name.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class SelectCategoryScreenDesktop1 extends StatefulWidget {
  const SelectCategoryScreenDesktop1({Key? key}) : super(key: key);

  @override
  State<SelectCategoryScreenDesktop1> createState() =>
      _SelectCategoryScreenDesktopState();
}

class _SelectCategoryScreenDesktopState
    extends State<SelectCategoryScreenDesktop1> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  List<bool> hoveredStatusList = List<bool>.generate(100, (index) => false);
  // int selectedIndex =
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
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;
    return DesktopView(
      isHome: false,

      appBarTitle: 'Select Category',
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.7,
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                return snapshot.connectionState != ConnectionState.waiting
                    ? Center(
                        child: SizedBox(
                          width: 430,
                          child: GridView.builder(
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
                              CategoryDoc model = CategoryDoc.fromJson(doc);
                              return InkWell(
                                onHover: (val) {
                                  setState(() {
                                    hoveredStatusList[index] = val;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    // hoveredStatusList[index] = val;
                                  });
                                  Navigator.pop(context, model);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: hoveredStatusList[index]
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
                                        color: !hoveredStatusList[index]
                                            ? primaryColor
                                            : bgColor,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CategoryName(
                                        categoryName: model.name,
                                        textColor: !hoveredStatusList[index]
                                            ? primaryColor
                                            : bgColor,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: NeumorphicLoader(
                          size: 75,
                          borderColor: primaryColor,
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
