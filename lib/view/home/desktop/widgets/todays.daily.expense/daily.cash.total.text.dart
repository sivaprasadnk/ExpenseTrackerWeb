// import 'package:expense_tracker/provider/home.provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DailyCashTotalText extends StatelessWidget {
//   const DailyCashTotalText({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.only(right: 10, left: 10),
//       child: Consumer<HomeProvider>(
//         builder: (_, provider, __) {
//           return Text(
//             "${provider.currencySymbol} ${provider.dailyCashTotal}",
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//               color: theme.scaffoldBackgroundColor,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
