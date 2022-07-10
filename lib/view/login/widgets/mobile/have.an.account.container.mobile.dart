import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAccoutContainerMobile extends StatelessWidget {
  const HaveAccoutContainerMobile({
    Key? key,
    this.fontSize = 18,
    this.height = 50,
  }) : super(key: key);

  final double fontSize;
  final double height;

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
            text: "Have an account ? ",
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
            children: [
              TextSpan(
                text: 'Login',
                style: TextStyle(
                  color: const Color.fromRGBO(0, 24, 88, 1),
                  fontSize: fontSize,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
