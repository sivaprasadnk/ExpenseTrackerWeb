import 'package:flutter/material.dart';

class SocialMediaSignInButton extends StatelessWidget {
  const SocialMediaSignInButton({
    Key? key,
    required this.icon,
    required this.textColor,
    required this.title,
    this.fontSize = 18,
  }) : super(key: key);

  final String title;
  final Color textColor;
  final IconData icon;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: textColor,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
