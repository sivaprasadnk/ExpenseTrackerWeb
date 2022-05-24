import 'package:expense_tracker/view/home/drawer/widgets/drawer.menu.item.dart';
import 'package:expense_tracker/view/home/drawer/widgets/theme.list.dart';
import 'package:flutter/material.dart';

class ChangeThemeMenu extends StatefulWidget {
  const ChangeThemeMenu({Key? key}) : super(key: key);

  @override
  State<ChangeThemeMenu> createState() => _ChangeThemeMenuState();
}

class _ChangeThemeMenuState extends State<ChangeThemeMenu> {
  @override
  Widget build(BuildContext context) {
    return DrawerMenuItem(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          barrierDismissible: false,
          context: context,
          barrierColor: Colors.black87,
          builder: (ctx) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: Colors.black12,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    child: ThemeList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      title: 'Change Theme',
      icon: Icons.format_paint_outlined,
    );
  }
}
