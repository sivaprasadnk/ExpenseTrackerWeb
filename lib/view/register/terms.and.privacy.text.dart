import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndPrivacyPolicyText extends StatelessWidget {
  const TermsAndPrivacyPolicyText({
    Key? key,
    this.width=300,
    this.horizontalPadding=120,
  }) : super(key: key);
  final double width;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        width: width,
        height: 50,
        child: RichText(
          text: TextSpan(
            text: 'By registering to our website/app, you agree to our',
            style: const TextStyle(
              color: Colors.black,
              // height: 10,
            ),
            children: [
              TextSpan(
                text: '  Terms and conditions ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await launchUrl(Uri.parse(
                        'https://sivaprasadnk.github.io/privacy-policy/'));
                  },
                style: const TextStyle(
                  color: Color.fromRGBO(0, 24, 88, 1),
                ),
              ),
              const TextSpan(text: 'and '),
              TextSpan(
                text: ' Privacy Policy ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await launchUrl(Uri.parse(
                        'https://sivaprasadnk.github.io/privacy-policy/'));
                  },
                style: const TextStyle(
                  color: Color.fromRGBO(0, 24, 88, 1),
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ),
    );
  }
}
