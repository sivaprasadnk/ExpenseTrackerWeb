import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/login/widgets/social.media.sign.in/social.media.sign.in.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FbSignInButton extends StatelessWidget {
  const FbSignInButton({
    Key? key,
    this.title = "Sign In with facebook",
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CursorWidget(
        onTap: facebookLogin,
        isButton: true,
        bgColor: const Color.fromARGB(255, 18, 64, 155),
        child:  SocialMediaSignInButton(
          textColor: Colors.white,
          icon: FontAwesomeIcons.facebook,
          title: title,
        ),
      ),
    );
  }

  facebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken!;
        debugPrint(" accessToken.token : ");
        // result.
        debugPrint(accessToken.token);
      } else {
        debugPrint("  result.status : ");
        debugPrint(result.status.toString());
        debugPrint(" result.message  :");
        debugPrint(result.message);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
