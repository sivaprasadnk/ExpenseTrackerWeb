// import 'package:expense_tracker/provider/home.provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TodaysTotalExpenseContainerMobile extends StatelessWidget {
//   const TodaysTotalExpenseContainerMobile({
//     Key? key,
//     required this.height,
//   }) : super(key: key);

//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     var primaryColor = theme.primaryColor;
//     var bgColor = theme.scaffoldBackgroundColor;
//     return Consumer<HomeProvider>(builder: (_, provider, __) {
//       return Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//             },
//             child: Container(
//               height: height,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 border: Border.all(
//                   width: 1,
//                   color: primaryColor,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Todays Total Expense :',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: bgColor,
//                     ),
//                   ),
//                   const DailyTotalText(),
//                 ],
//               ),
//             ),
//           ),
//           CashTitleText(theme: theme),
//           OnlineTitleText(theme: theme),
//           CashTotalContainer(
//             theme: theme,
//             amount: "0",
//           ),
//           OnlineTotalContainer(
//             theme: theme,
//             amount: "0",
//           )
//         ],
//       );
//     });
//   }
// }
