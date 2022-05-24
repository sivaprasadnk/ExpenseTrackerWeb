// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CursorWidget{
// static button({
//  required BuildContext context,
//  required VoidCallback onTap,
// }){
//   return InkWell(
//       // hoverColor: Colors.,
//       mouseCursor: SystemMouseCursors.click,
//       splashColor: Colors.transparent,
//       // splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       onTap: () {
//           onTap.call();
        
//       },
//       onHover: (val) {
//         setState(() {
//           isHovered = val;
//         });
//       },
//       child: widget.isButton
//           ? Container(
//               height: 40,
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 color: widget.bgColor,
//                 borderRadius: BorderRadius.circular(8),
//                 // border: ,
//                 boxShadow: isHovered
//                     ? [
//                         const BoxShadow(
//                           color: Colors.black38,
//                           blurRadius: 10.0,
//                         )
//                       ]
//                     : [
//                         const BoxShadow(
//                           color: Colors.transparent,
//                           blurRadius: 0.0,
//                         )
//                       ],
//               ),
//               child: widget.child,
//             )
//           : widget.child,
//     );
// }
// }