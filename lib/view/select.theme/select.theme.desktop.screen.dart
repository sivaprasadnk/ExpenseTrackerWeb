import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/themes.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/desktop.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectThemeDesktopScreen extends StatelessWidget {
  const SelectThemeDesktopScreen({Key? key}) : super(key: key);
  static const routeName = '/SelectTheme';
  @override
  Widget build(BuildContext context) {
    return DesktopView(
      topPadding: 50,
      child: Center(
        child: SizedBox(
          width: 450,
          child: ListView(
            children: const [
              DarkThemeCheckBox(),
              SizedBox(
                height: 20,
              ),
              ThemeGrid(),
              SizedBox(
                height: 50,
              ),
              ApplyButton(),
            ],
          ),
        ),
      ),
      appBarTitle: 'Select Theme',
    );
  }
}

class DarkThemeCheckBox extends StatelessWidget {
  const DarkThemeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 1,
        ),
        Consumer<ThemeNotifier>(
          builder: (_, provider, __) {
            return Checkbox(
              checkColor: provider.themeData.brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              value: provider.themeData.brightness == Brightness.dark,
              onChanged: (val) {
                provider.toggleBrightness();
              },
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          'Dark Theme',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

class ApplyButton extends StatelessWidget {
  const ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CursorWidget(
      buttonHeight: 50,
      isButton: true,
      bgColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Text(
          'Apply',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}

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
