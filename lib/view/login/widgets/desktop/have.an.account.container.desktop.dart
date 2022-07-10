import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAccoutContainerDesktop extends StatelessWidget {
  const HaveAccoutContainerDesktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50),
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
            style: const TextStyle(
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: 'Login',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 24, 88, 1),
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
