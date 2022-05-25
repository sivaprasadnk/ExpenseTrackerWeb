import 'package:expense_tracker/view/home/drawer/widgets/app.name.screen.dart';
import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AppNameScreen()));
      },
      child: Container(
        // height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Expense \n Tracker',
            style: TextStyle(fontSize: 55),
          ),
        ),
      ),
    );
  }
}
