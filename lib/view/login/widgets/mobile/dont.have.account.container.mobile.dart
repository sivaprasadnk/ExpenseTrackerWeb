import 'package:expense_tracker/view/register/register.screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAccoutContainerMobile extends StatelessWidget {
  const DontHaveAccoutContainerMobile({
    Key? key,
    this.height = 50,
    this.fontSize = 15,
  }) : super(key: key);
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: "Don't have an account ? ",
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
            children: [
              TextSpan(
                text: 'Register',
                style: TextStyle(
                  color: const Color.fromRGBO(0, 24, 88, 1),
                  fontSize: fontSize,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen()));
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
