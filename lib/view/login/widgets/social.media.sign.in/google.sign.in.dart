import 'package:expense_tracker/controller/auth.controller.dart';
import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/login/widgets/social.media.sign.in/social.media.sign.in.button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
    this.title = "Sign In with Google",
    required this.googleSignIn,
  }) : super(key: key);

  final String title;
  final GoogleSignIn googleSignIn;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CursorWidget(
        onTap: () async {
          await googleLogin(context);
        },
        isButton: true,
        bgColor: Colors.white,
        child: SocialMediaSignInButton(
          textColor: Colors.black,
          icon: FontAwesomeIcons.google,
          title: title,
        ),
      ),
    );
  }

  Future googleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        var width = MediaQuery.of(context).size.width;
        AuthController.googleLogin(
          context: context,
          account: account,
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
