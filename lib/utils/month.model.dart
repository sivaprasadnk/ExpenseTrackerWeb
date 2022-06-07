import 'package:expense_tracker/utils/custom.dialog.dart';
import 'package:flutter/material.dart';

class MonthModel {
  int index;
  String name;
  MonthModel({
    required this.index,
    required this.name,
  });
}

class MonthYearPicker {
  static final List<MonthModel> _monthModelList = [
    MonthModel(index: 1, name: 'Jan'),
    MonthModel(index: 2, name: 'Feb'),
    MonthModel(index: 3, name: 'Mar'),
    MonthModel(index: 4, name: 'Apr'),
    MonthModel(index: 5, name: 'May'),
    MonthModel(index: 6, name: 'Jun'),
    MonthModel(index: 7, name: 'Jul'),
    MonthModel(index: 8, name: 'Aug'),
    MonthModel(index: 9, name: 'Sep'),
    MonthModel(index: 10, name: 'Oct'),
    MonthModel(index: 11, name: 'Nov'),
    MonthModel(index: 12, name: 'Dec'),
  ];

  static Future showMonthYearPicker(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    var bgColor = theme.scaffoldBackgroundColor;

    int selectedYear = DateTime.now().year;
    var selectedMonth = DateTime.now().month;
    await showDialog<DateTime>(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return CustomDialog(
            child: Material(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Container(
                    height: 210,
                    width: 370,
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border.all(
                        color: primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            'Select Month ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SizedBox(
                            height: 100,
                            width: 300,
                            child: GridView.builder(
                              itemCount: _monthModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                              ),
                              itemBuilder: (_, index) {
                                var monthModel = _monthModelList[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      // hoveredStatusList[index] = val;
                                      selectedMonth = index + 1;
                                    });
                                  },
                                  onHover: (val) {},
                                  child: MonthContainer(
                                    month: monthModel.name,
                                    fillColor: index + 1 == selectedMonth
                                        ? primaryColor
                                        : bgColor,
                                    borderColor: index + 1 == selectedMonth
                                        ? primaryColor
                                        : bgColor,
                                    textColor: index + 1 != selectedMonth
                                        ? primaryColor
                                        : bgColor,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  border: Border.all(
                                    color: primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                String selectedMonthString = selectedMonth < 10
                                    ? "0$selectedMonth"
                                    : "$selectedMonth";
                                var selectedDate = DateTime.parse(
                                    '$selectedYear-$selectedMonthString-01');
                                debugPrint('.. !@@@22');

                                Navigator.pop(context, selectedDate);
                              },
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(
                                    color: primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: bgColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: 10,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedYear = selectedYear - 1;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 10,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            selectedYear.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedYear = selectedYear + 1;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
    String selectedMonthString =
        selectedMonth < 10 ? "0$selectedMonth" : "$selectedMonth";
    debugPrint('.. !@@@');
    return DateTime.parse('$selectedYear-$selectedMonthString-01');
    // return null;
  }
}

class MonthContainer extends StatelessWidget {
  const MonthContainer({
    Key? key,
    required this.month,
    required this.fillColor,
    required this.borderColor,
    required this.textColor,
  }) : super(key: key);

  final String month;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        color: fillColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          month,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
