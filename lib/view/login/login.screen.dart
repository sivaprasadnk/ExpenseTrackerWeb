import 'package:auth_buttons/auth_buttons.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/controller/auth.controller.dart';
import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/login/widgets/login.submit.button.dart';
import 'package:expense_tracker/view/login/widgets/text.field.container.dart';
import 'package:expense_tracker/view/login/widgets/text.field.title.dart';
import 'package:expense_tracker/view/register/register.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'Login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _emailTextOpacity;
  late Animation<double> _emailFieldOpacity;
  late Animation<double> _passwordTextOpacity;
  late Animation<double> _passwordFieldOpacity;
  late Animation<Offset> _emailTextSlide;
  late Animation<Offset> _emailFieldSlide;
  late Animation<Offset> _passwordTextSlide;
  late Animation<Offset> _passwordFieldSlide;

  String email = "";
  String password = "";
  bool showPassword = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn? _googleSignIn;
  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
    );
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _emailTextOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.linear),
      ),
    );

    _emailTextSlide = Tween<Offset>(
      begin: const Offset(0, -0.9),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.linear),
      ),
    );

    _emailFieldOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.58, curve: Curves.easeIn),
      ),
    );

    _emailFieldSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.6, curve: Curves.easeIn),
      ),
    );
    _passwordTextOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.7, curve: Curves.easeIn),
      ),
    );
    _passwordTextSlide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 0.75, curve: Curves.easeIn),
      ),
    );
    _passwordFieldOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 0.95, curve: Curves.easeIn),
      ),
    );

    _passwordFieldSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 0.99, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  FocusNode textSecondFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const opacityDuration = Duration(milliseconds: 900);
    const slideDuration = Duration(milliseconds: 400);
    return Form(
      key: _formKey,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: const Text(
          kCopyRightText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 24, 88, 1),
          ),
        ),
        body: Container(
          height: screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/mesh1.jpg'),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    kExpenseTrackerText + '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 24, 88, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Container(
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          AnimatedOpacity(
                            duration: opacityDuration,
                            opacity: _emailTextOpacity.value,
                            child: AnimatedSlide(
                              duration: slideDuration,
                              offset: _emailTextSlide.value,
                              child: const TextFieldTitle(title: 'Email'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedOpacity(
                            duration: opacityDuration,
                            opacity: _emailFieldOpacity.value,
                            child: AnimatedSlide(
                              duration: slideDuration,
                              offset: _emailFieldSlide.value,
                              child: TextFieldContainer(
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(textSecondFocusNode);
                                  },
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(textSecondFocusNode);
                                  },
                                  autocorrect: false,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (val) {
                                    email = val.toString();
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          AnimatedOpacity(
                            duration: opacityDuration,
                            opacity: _passwordTextOpacity.value,
                            child: AnimatedSlide(
                              duration: slideDuration,
                              offset: _passwordTextSlide.value,
                              child: const TextFieldTitle(title: 'Password'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedOpacity(
                            duration: opacityDuration,
                            opacity: _passwordFieldOpacity.value,
                            child: AnimatedSlide(
                              duration: slideDuration,
                              offset: _passwordFieldSlide.value,
                              child: TextFieldContainer(
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: <Widget>[
                                    TextFormField(
                                      focusNode: textSecondFocusNode,
                                      obscureText: !showPassword,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      onSaved: (val) {
                                        password = val.toString();
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                    ),
                                    IconButton(
                                      icon: showPassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      onPressed: () {
                                        // do something
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                // child: TextFormField(
                                //   focusNode: textSecondFocusNode,
                                //   obscureText: !showPassword,
                                //   style: const TextStyle(
                                //     color: Colors.black,
                                //   ),
                                //   onSaved: (val) {
                                //     password = val.toString();
                                //   },
                                //   decoration: InputDecoration(
                                //     suffixIcon: GestureDetector(
                                //       onTap: () {
                                //         setState(() {
                                //           showPassword = !showPassword;
                                //         });
                                //       },
                                //       child: const Icon(
                                //           Icons.remove_red_eye_rounded),
                                //     ),
                                //     hintText: '',
                                //     border: InputBorder.none,
                                //     isDense: true,
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: CursorWidget(
                              onTap: validateAndProceed,
                              isButton: true,
                              bgColor: const Color.fromRGBO(0, 24, 88, 1),
                              child: const LoginButton(
                                title: 'Login',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
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
                                                builder: (_) =>
                                                    const RegisterScreen()));
                                      },
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GoogleAuthButton(
                      onPressed: () async {
                        try {
                          GoogleSignInAccount? account =
                              await _googleSignIn!.signIn();
                          if (account != null) {
                            AuthController.googleSignIn(
                                context: context, account: account);
                          }
                        } catch (error) {
                          debugPrint(error.toString());
                        }
                      },
                      darkMode: true,
                      isLoading: false,
                      style: const AuthButtonStyle(
                        padding: EdgeInsets.all(9),
                        // separator: ,
                        buttonType: AuthButtonType.icon,
                        iconType: AuthIconType.secondary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    FacebookAuthButton(
                      onPressed: () async {
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
                      },
                      darkMode: true,
                      isLoading: false,
                      style: const AuthButtonStyle(
                        padding: EdgeInsets.all(9),
                        // separator: ,
                        buttonType: AuthButtonType.icon,
                        iconType: AuthIconType.secondary,
                      ),
                    ),
                  ],
                ),
//                 GestureDetector(
//                   onTap: () async {
//                     try {
//                       final LoginResult result = await FacebookAuth.instance
//                           .login(); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//                       if (result.status == LoginStatus.success) {
//                         // you are logged
//                         final AccessToken accessToken = result.accessToken!;
//                         debugPrint(" accessToken.token : ");
//                         debugPrint(accessToken.token);
//                       } else {
//                         debugPrint("  result.status : ");
//                         debugPrint(result.status.toString());
//                         debugPrint(" result.message  :");
//                         debugPrint(result.message);
//                       }
//                     } catch (error) {
//                       debugPrint(error.toString());
//                     }
//                   },
//                   child: Container(
//                     width: 300,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Facebook  Login',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateAndProceed() {
    _formKey.currentState!.save();
    AuthController.login(context, email.trim(), password.trim());
  }
}
