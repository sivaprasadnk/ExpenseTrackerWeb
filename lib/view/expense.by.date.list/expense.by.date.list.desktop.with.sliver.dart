// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/common_strings.dart';
// import 'package:expense_tracker/model/expense.date.model.dart';
// import 'package:expense_tracker/model/expense.model.dart';
// import 'package:expense_tracker/provider/theme_notifier.dart';
// import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.card.desktop.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sliver_fab/sliver_fab.dart';

// class ExpenseByDateListScreenWithSliver extends StatelessWidget {
//   const ExpenseByDateListScreenWithSliver({
//     Key? key,
//     required this.expenseDateItem,
//   }) : super(key: key);
//   final ExpenseDate expenseDateItem;
//   @override
//   Widget build(BuildContext context) {
//     var userId = FirebaseAuth.instance.currentUser!.uid;
//     final screenSize = MediaQuery.of(context).size;
//     final screenHeight = screenSize.height;
//     var primaryColor = Provider.of<ThemeNotifier>(context, listen: false)
//         .themeData
//         .primaryColor;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: false,
//         title: Container(
//           padding: const EdgeInsets.all(10),
//           // decoration: BoxDecoration(
//           //   border: Border.all(
//           //     color: primaryColor,
//           //   ),
//           //   borderRadius: BorderRadius.circular(8),
//           // ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 expenseDateItem.day,
//                 style: TextStyle(
//                   // fontFamily: 'Rajdhani',
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor,
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 expenseDateItem.month,
//                 style: TextStyle(
//                   // fontFamily: 'Rajdhani',
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor,
//                   // fontSize: 40,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white
//                 : Colors.black,
//           ),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(kUsersCollection)
//             .doc(userId)
//             .collection(kExpenseDatesNewCollection)
//             .doc(expenseDateItem.date)
//             .collection(kExpenseCollection)
//             .orderBy('createdDate')
//             .snapshots(),
//         builder: (_, snapshot) {
//           return snapshot.connectionState != ConnectionState.done
//               ? snapshot.hasData &&
//                       (snapshot.data! as QuerySnapshot).docs.isNotEmpty
//                   ? SliverFab(
//                       expandedHeight: 200,
//                       floatingPosition:
//                           const FloatingPosition(left: 20, right: 20),
//                       floatingWidget: Container(
//                         height: 100,
//                         width: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Center(
//                           child: Text('Total Transactions : 1'),
//                         ),
//                       ),
//                       slivers: [
//                         SliverAppBar(
//                           expandedHeight: 150,
//                           flexibleSpace: FlexibleSpaceBar(
//                             title: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   expenseDateItem.day,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: primaryColor,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   expenseDateItem.month,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: primaryColor,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SliverList(
//                             delegate: SliverChildBuilderDelegate((_, index) {
//                           var doc =
//                               (snapshot.data! as QuerySnapshot).docs[index];
//                           Expense expense = Expense(
//                             amount: doc['amount'],
//                             mode: doc['mode'],
//                             categoryIndex: doc['categoryId'],
//                             categoryName: doc['categoryName'],
//                             createdDate: doc['createdDate'],
//                             expenseDay: doc['expenseDay'],
//                             details: doc['details'],
//                             expenseDocId: doc['expenseDocId'],
//                             expenseTitle: doc['expenseTitle'],
//                             expenseDate: doc['expenseDate'],
//                             expenseMonth: doc['expenseMonth'],
//                           );
//                           return ExpenseDetailsCardDesktop(
//                             expense: expense,
//                             width: 450,
//                           );
//                         }))
//                       ],
//                     )
//                   : SizedBox(
//                       height: screenHeight * 0.5,
//                       child: const Center(
//                         child: Text(
//                           'No Data !',
//                         ),
//                       ),
//                     )
//               : const Center(
//                   child: CircularProgressIndicator(),
//                 );
//         },
//       ),
//     );
//   }
// }

// /*

// SliverFab(
//         expandedHeight: 200,
//         floatingPosition: const FloatingPosition(left: 20, right: 20),
//         floatingWidget: Container(
//           height: 100,
//           width: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Center(
//             child: Text('Total Transactions : 1'),
//           ),
//         ),
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 150,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     expenseDateItem.day,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: primaryColor,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     expenseDateItem.month,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//           */
