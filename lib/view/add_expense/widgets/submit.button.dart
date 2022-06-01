import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, this.width = 450}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;
    return Container(
      height: 50,
      width: width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Submit',
          style: TextStyle(
            fontSize: 20,
            color: theme.scaffoldBackgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
