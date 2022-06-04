// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/common_strings.dart';
// import 'package:expense_tracker/cursor.widget.dart';
// import 'package:expense_tracker/model/expense.model.dart';
// import 'package:expense_tracker/view/expense.by.date.list/widgets/expense.details.card.desktop.dart';
// import 'package:expense_tracker/view/home/desktop/home.screen.desktop.dart';
// import 'package:expense_tracker/view/home/drawer/drawer.screen.dart';
// import 'package:expense_tracker/view/title.widget.dart';
// import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.desktop.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SearchScreenDesktop extends StatefulWidget {
//   const SearchScreenDesktop({Key? key}) : super(key: key);

//   @override
//   State<SearchScreenDesktop> createState() => _SearchScreenDesktopState();
// }

// class _SearchScreenDesktopState extends State<SearchScreenDesktop> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey();

//   String searchWord = "";

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     var userId = FirebaseAuth.instance.currentUser!.uid;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       drawerEnableOpenDragGesture: false,
//       key: _key,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 5, top: 5),
//           child: CursorWidget(
//             onTap: () {
//               Navigator.pushNamedAndRemoveUntil(
//                   context, HomeScreenDesktop.routeName, (r) => false);
//             },
//             child: Text(
//               'EXPENSE TRACKER',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontFamily: 'Rajdhani',
//                 fontWeight: FontWeight.bold,
//                 color: theme.textTheme.bodyMedium!.color,
//               ),
//             ),
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: CursorWidget(
//               onTap: () {
//                 _key.currentState!.openEndDrawer();
//               },
//               child: Icon(
//                 Icons.menu,
//                 color: theme.brightness == Brightness.dark
//                     ? Colors.white
//                     : Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//       endDrawer: const DrawerScreen(),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: const [
//                 TitleWidget(title: 'Search'),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: SizedBox(
//                     width: 450,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               color: theme.primaryColor,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Center(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: TextFormField(
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                 ),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     searchWord = value;
//                                   });
//                                 },
//                                 autofocus: true,
//                                 decoration: const InputDecoration(
//                                   hintStyle: TextStyle(
//                                     color: Colors.grey,
//                                   ),
//                                   border: InputBorder.none,
//                                   hintText:
//                                       'Enter text to search in expense titles',
//                                   isDense: true,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 50,
//                         ),
//                         Expanded(
//                           child: StreamBuilder(
//                             stream: FirebaseFirestore.instance
//                                 .collection(kUsersCollection)
//                                 .doc(userId)
//                                 .collection(kRecentExpensesCollection)
//                                 .where('expenseTitle_i',
//                                     isEqualTo: searchWord.toLowerCase())
//                                 .snapshots(),
//                             builder: (_, snapshot) {
//                               return snapshot.connectionState !=
//                                       ConnectionState.done
//                                   ? snapshot.hasData &&
//                                           (snapshot.data! as QuerySnapshot)
//                                               .docs
//                                               .isNotEmpty
//                                       ? SizedBox(
//                                           child: ListView.separated(
//                                             separatorBuilder: (ctx, _) =>
//                                                 const SizedBox(
//                                               height: 10,
//                                             ),
//                                             itemCount: (snapshot.data!
//                                                     as QuerySnapshot)
//                                                 .docs
//                                                 .length,
//                                             itemBuilder: (ctx, index) {
//                                               var doc = (snapshot.data!
//                                                       as QuerySnapshot)
//                                                   .docs[index];
//                                               Expense expense =
//                                                   Expense.fromJson(doc);
//                                               return Center(
//                                                 child: SizedBox(
//                                                   width: 450,
//                                                   child:
//                                                       ExpenseDetailsCardDesktop(
//                                                     expense: expense,
//                                                     width: 450,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         )
//                                       : const NoExpenseContainerDesktop(
//                                           title: 'No search results found !',
//                                         )
//                                   : const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
