import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/utils/category.list.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCategoryScreenMobile extends StatefulWidget {
  const SelectCategoryScreenMobile({Key? key}) : super(key: key);

  static const routeName = 'SelectCategory';

  @override
  State<SelectCategoryScreenMobile> createState() =>
      _SelectCategoryScreenMobileState();
}

class _SelectCategoryScreenMobileState
    extends State<SelectCategoryScreenMobile> {
  int selectedIndex = 100;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return MobileView(
      appBarTitle: 'Select Category',
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.7,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: CategoryList.list.length,
              itemBuilder: (_, index) {
                var category = CategoryList.list[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, index);
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
                          category.icon,
                          color: index != selectedIndex
                              ? primaryColor
                              : theme.themeData.scaffoldBackgroundColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: index != selectedIndex
                                ? primaryColor
                                : theme.themeData.scaffoldBackgroundColor,
                          ),
                        )
                      ],
                    ),
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
