import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (_, provider, __) {
        return SizedBox(
          height: 300,
          child: GridView.builder(
            itemCount: AppTheme.values.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 35,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              final ThemeData? theme = appThemeData[AppTheme.values[index]];
              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {
                    provider.setTheme(AppTheme.values[index], index, context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    // backgroundColor: provider.themeIndex != index
                    //     ? Colors.transparent
                    //     : Colors.black,
                    radius: 16,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: theme!.scaffoldBackgroundColor,
                    ),
                  ),
                ),
              );
            },
          ),
          // child: ListView.separated(
          //   separatorBuilder: (ctx, i) => const SizedBox(
          //     width: 5,
          //   ),
          //   scrollDirection: Axis.horizontal,
          //   shrinkWrap: true,
          //   itemCount: AppTheme.values.length,
          //   itemBuilder: (ctx, index) {
          //     final ThemeData? theme = appThemeData[AppTheme.values[index]];
          //     return Padding(
          //       padding: const EdgeInsets.only(left: 15),
          //       child: GestureDetector(
          //         onTap: () {
          //           provider.setTheme(AppTheme.values[index], index, context);
          //         },
          //         child: CircleAvatar(
          //           backgroundColor: Colors.black,
          //           // backgroundColor: provider.themeIndex != index
          //           //     ? Colors.transparent
          //           //     : Colors.black,
          //           radius: 16,
          //           child: CircleAvatar(
          //             radius: 15,
          //             backgroundColor: theme!.scaffoldBackgroundColor,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        );
      },
    );
  }
}
