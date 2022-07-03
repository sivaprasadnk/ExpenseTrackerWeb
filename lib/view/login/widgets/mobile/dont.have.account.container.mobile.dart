import 'package:expense_tracker/view/register/register.screen.desktop.dart';
import 'package:expense_tracker/view/register/register.screen.mobile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAccoutContainerMobile extends StatelessWidget {
  const DontHaveAccoutContainerMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
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
            style: const TextStyle(
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: 'Register',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 24, 88, 1),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreenMobile()));
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
