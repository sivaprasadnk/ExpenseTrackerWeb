import 'package:expense_tracker/controller/auth.controller.dart';
import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/login/widgets/social.media.sign.in/social.media.sign.in.button.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
        onTap: () {
          facebookLogin(context);
        },
        isButton: true,
        bgColor: const Color.fromARGB(255, 18, 64, 155),
        child: SocialMediaSignInButton(
          textColor: Colors.white,
          icon: FontAwesomeIcons.facebook,
          title: title,
        ),
      ),
    );
  }

  facebookLogin(BuildContext context) async {
    try {
      var width = MediaQuery.of(context).size.width;

      AuthController.fbLogin(context: context, isMobileScreen: width < 480);
//       final LoginResult result = await FacebookAuth.instance
//           .login(); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//       if (result.status == LoginStatus.success) {
//         // you are logged
//         final AccessToken accessToken = result.accessToken!;
//         debugPrint(" accessToken.token : ");
//         // accessToken.
//         debugPrint(accessToken.token);
//         AuthController.fbLogin(context: context);
//       } else {
//         debugPrint("  result.status : ");
//         debugPrint(result.status.toString());
//         debugPrint(" result.message  :");
//         debugPrint(result.message);
//       }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
