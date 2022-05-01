import 'package:expense_tracker/utils/category.list.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        bottomNavigationBar: GestureDetector(
          onTap: () {
            if (selectedIndex != 100) {
              Navigator.pop(context, selectedIndex);
            }
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.cyan,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Select',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Rajdhani',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Select Category'),
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
                    var category = categoryList[index];
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
                                ? Colors.cyan
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.cyan,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(category.icon),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(category.name)
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
