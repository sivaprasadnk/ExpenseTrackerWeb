import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/utils/category.list.dart';
import 'package:expense_tracker/view/windows/small/add_expense/widgets/submit.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  int selectedIndex = 100;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return Scaffold(
        bottomNavigationBar: GestureDetector(
          onTap: () {
            if (selectedIndex != 100) {
              Navigator.pop(context, selectedIndex);
            }
          },
          child: SubmitButton(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
          title: Text(
            'Select Category',
            style: TextStyle(
              color: primaryColor,
              fontFamily: 'Rajdhani',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  itemCount: 5,
                  itemBuilder: (_, index) {
                    var category = CategoryList.list[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
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

                    // return Container();
                    // return Container(
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.cyan,
                    //       ),
                    //       borderRadius: BorderRadius.circular(8)),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       index == 0
                    //           ? const FaIcon(FontAwesomeIcons.bowlFood)
                    //           : index == 1
                    //               ? const FaIcon(FontAwesomeIcons.taxi)
                    //               : index == 2
                    //                   ? const FaIcon(FontAwesomeIcons.hospital)
                    //                   : const Icon(
                    //                       FontAwesomeIcons.bottleWater),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       const Text(
                    //         'Food',
                    //       )
                    //     ],
                    //   ),
                    // );

                    // return Container();
                  },
                ),
              )
            ],
          ),
        ));
  }
}
