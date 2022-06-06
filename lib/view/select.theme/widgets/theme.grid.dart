import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/themes.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeGrid extends StatelessWidget {
  const ThemeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (_, provider, __) {
        return Padding(
          padding: const EdgeInsets.only(left: 0, top: 0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: AppTheme.values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 120,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              final ThemeData? theme = appThemeData[AppTheme.values[index]];
              String title = AppTheme.values[index].name.toString().initCap();
              return GestureDetector(
                onTap: () {
                  provider.setTheme(AppTheme.values[index], index, context);
                },
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Rajdhani',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundColor: theme!.scaffoldBackgroundColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundColor: theme.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (provider.themeIndex == index)
                      const Positioned.fill(
                        right: 8,
                        top: 8,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
