import 'package:expense_tracker/view/sample.text.dart';
import 'package:flutter/material.dart';

class SettingsTextContainer extends StatelessWidget {
  const SettingsTextContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.primaryColor;
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => const SampleText()));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                Icons.settings,
                size: 45,
              ),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
