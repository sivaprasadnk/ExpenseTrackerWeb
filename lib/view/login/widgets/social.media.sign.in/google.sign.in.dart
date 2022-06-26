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
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CursorWidget(
        onTap: () {
          googleLogin(context);
        },
        isButton: true,
        bgColor: Colors.white,
        child:  SocialMediaSignInButton(
          textColor: Colors.black,
          icon: FontAwesomeIcons.google,
          title: title,
        ),
      ),
    );
  }

  googleLogin(BuildContext context) async {
    try {
      GoogleSignIn? _googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
      );
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        AuthController.googleSignIn(context: context, account: account);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
