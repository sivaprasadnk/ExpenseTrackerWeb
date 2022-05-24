// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/common_strings.dart';
// import 'package:expense_tracker/model/expense.date.model.dart';
// import 'package:expense_tracker/provider/theme_notifier.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ExpenseDateListDesktopSmallWithSliver extends StatefulWidget {
//   const ExpenseDateListDesktopSmallWithSliver({Key? key}) : super(key: key);

//   @override
//   _ExpenseDateListDesktopSmallWithSliverState createState() =>
//       _ExpenseDateListDesktopSmallWithSliverState();
// }

// class _ExpenseDateListDesktopSmallWithSliverState
//     extends State<ExpenseDateListDesktopSmallWithSliver> {
//   bool onHovered = false;

//   List<bool> hoveredStatusList = List<bool>.generate(100, (index) => false);

//   @override
//   Widget build(BuildContext context) {
//     var userId = FirebaseAuth.instance.currentUser!.uid;
//     final screenSize = MediaQuery.of(context).size;
//     final screenHeight = screenSize.height;
//     final ThemeNotifier theme =
//         Provider.of<ThemeNotifier>(context, listen: true);
//     var primaryColor = theme.themeData.primaryColor;

//     return Scaffold(
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   backgroundColor: Colors.transparent,
//       //   leading: GestureDetector(
//       //     onTap: () {
//       //       Navigator.pop(context);
//       //     },
//       //     child: Icon(
//       //       Icons.arrow_back_ios,
//       //       color: Theme.of(context).brightness == Brightness.dark
//       //           ? Colors.white
//       //           : Colors.black,
//       //     ),
//       //   ),
//       // ),
//       body: Center(
//         child: SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.all(0.0),
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection(kUsersCollection)
//                   .doc(userId)
//                   .collection(kExpenseDatesNewCollection)
//                   .snapshots(),
//               builder: (_, snapshot) {
//                 return snapshot.connectionState != ConnectionState.done
//                     ? snapshot.hasData &&
//                             (snapshot.data! as QuerySnapshot).docs.isNotEmpty
//                         ? CustomScrollView(
//                             slivers: [
//                               const SliverAppBar(
//                                 expandedHeight: 100,
//                                 collapsedHeight: 60,
//                                 flexibleSpace: FlexibleSpaceBar(
//                                   title: Text('Expenses By Date'),
//                                 ),
//                               ),
//                               SliverList(
//                                 delegate: SliverChildBuilderDelegate(
//                                     (_, index) {
//                                   var doc = (snapshot.data! as QuerySnapshot)
//                                       .docs[index];
//                                   var expDate = ExpenseDate(
//                                     day: doc['day'],
//                                     date: doc['date'],
//                                     month: doc['month'],
//                                     totalExpense: doc['totalExpense'],
//                                     updatedTime: doc['updatedTime'],
//                                   );
//                                   return Container(
//                                     margin: const EdgeInsets.only(
//                                       left: 10,
//                                       right: 10,
//                                       bottom: 10,
//                                     ),
//                                     width: 450,
//                                     height: 75,
//                                     decoration: BoxDecoration(
//                                         color: theme
//                                             .themeData.scaffoldBackgroundColor,
//                                         border: Border.all(
//                                           width: 2,
//                                           color: theme.themeData.primaryColor,
//                                         ),
//                                         borderRadius: BorderRadius.circular(8)),
//                                     child: Center(
//                                       child: Text(
//                                         expDate.date + " " + expDate.month,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                     childCount:
//                                         (snapshot.data! as QuerySnapshot)
//                                             .docs
//                                             .length),
//                               ),
//                               // SliverGrid(
//                               //   delegate: SliverChildBuilderDelegate(
//                               //       (context, index) {
//                               //     var doc = (snapshot.data! as QuerySnapshot)
//                               //         .docs[index];
//                               //     var expDate = ExpenseDate(
//                               //       day: doc['day'],
//                               //       date: doc['date'],
//                               //       month: doc['month'],
//                               //       totalExpense: doc['totalExpense'],
//                               //       updatedTime: doc['updatedTime'],
//                               //     );
//                               //     return InkWell(
//                               //       hoverColor: Colors.transparent,
//                               //       onHover: (val) {
//                               //         setState(() {
//                               //           hoveredStatusList[index] = val;
//                               //         });
//                               //       },
//                               //       onTap: () {
//                               //         Navigator.push(
//                               //             context,
//                               //             MaterialPageRoute(
//                               //                 builder: (_) =>
//                               //                     ExpenseByDateListScreen(
//                               //                       expenseDateItem: expDate,
//                               //                     )));
//                               //       },
//                               //       child: Stack(
//                               //         children: [
//                               //           Container(
//                               //             padding: EdgeInsets.zero,
//                               //             width: 130,
//                               //             height: 80,
//                               //             margin:
//                               //                 const EdgeInsets.only(top: 10),
//                               //             decoration: BoxDecoration(
//                               //               border: Border.all(
//                               //                 width: 2,
//                               //                 color: !hoveredStatusList[index]
//                               //                     ? primaryColor
//                               //                     : theme.themeData.cardColor,
//                               //               ),
//                               //               borderRadius:
//                               //                   BorderRadius.circular(8),
//                               //             ),
//                               //             child: Column(
//                               //               children: [
//                               //                 ExpenseDateText(
//                               //                   date: expDate.day,
//                               //                   fontColor: theme
//                               //                       .themeData
//                               //                       .textTheme
//                               //                       .bodyMedium!
//                               //                       .color!,
//                               //                 ),
//                               //                 ExpenseMonthText(
//                               //                   month: expDate.month,
//                               //                 ),
//                               //               ],
//                               //             ),
//                               //           ),
//                               //           ExpenseAmountText(
//                               //             fillColor: theme.themeData
//                               //                 .scaffoldBackgroundColor,
//                               //             borderColor:
//                               //                 !hoveredStatusList[index]
//                               //                     ? primaryColor
//                               //                     : theme.themeData.cardColor,
//                               //             amount:
//                               //                 expDate.totalExpense.toString(),
//                               //           )
//                               //         ],
//                               //       ),
//                               //     );
//                               //   },
//                               //       childCount:
//                               //           (snapshot.data! as QuerySnapshot)
//                               //               .docs
//                               //               .length),
//                               //   gridDelegate:
//                               //       const SliverGridDelegateWithFixedCrossAxisCount(
//                               //     crossAxisCount: 3,
//                               //     mainAxisSpacing: 20,
//                               //     crossAxisSpacing: 20,
//                               //     mainAxisExtent: 90,
//                               //   ),
//                               // )
//                             ],
//                           )
//                         : SizedBox(
//                             height: screenHeight * 0.5,
//                             child: const Center(
//                               child: Text(
//                                 'No Data !',
//                                 style: TextStyle(
//                                     // color: Colors.white,
//                                     ),
//                               ),
//                             ),
//                           )
//                     : const Center(
//                         child: CircularProgressIndicator(),
//                       );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
