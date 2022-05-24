import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeList extends StatelessWidget {
  const ThemeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (_, provider, __) {
        return Container(
          height: 160,
          width: 450,
          decoration: BoxDecoration(
            color: provider.themeData.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Select theme ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: AppTheme.values.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 35,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, index) {
                  final ThemeData? theme = appThemeData[AppTheme.values[index]];
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, top: 0),
                    child: GestureDetector(
                      onTap: () {
                        provider.setTheme(
                            AppTheme.values[index], index, context);
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 45, top: 1),
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 16,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: theme!.scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          if (provider.themeIndex == index)
                            const Positioned.fill(
                              bottom: 10,
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.check,
                                  size: 25,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
