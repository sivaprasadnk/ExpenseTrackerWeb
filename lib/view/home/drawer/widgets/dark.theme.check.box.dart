// import 'package:expense_tracker/provider/theme_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DarkThemeCheckBox extends StatefulWidget {
//   const DarkThemeCheckBox({Key? key}) : super(key: key);

//   @override
//   State<DarkThemeCheckBox> createState() => _DarkThemeCheckBoxState();
// }

// class _DarkThemeCheckBoxState extends State<DarkThemeCheckBox> {
//   bool isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       hoverColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       onTap: () {},
//       onHover: (val) {
//         setState(() {
//           isHovered = val;
//         });
//       },
//       child: Row(
//         children: [
//           const SizedBox(
//             width: 20,
//           ),
//           Consumer<ThemeNotifier>(
//             builder: (_, provider, __) {
//               return Checkbox(
//                 value: provider.themeData.brightness == Brightness.dark,
//                 onChanged: (val) {
//                   provider.toggleBrightness();
//                 },
//               );
//             },
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Text(
//             'Dark Theme',
//             style: TextStyle(
//               fontSize: 20,
//               color: !isHovered
//                   ? Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white
//                       : Colors.black
//                   : Theme.of(context).cardColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
