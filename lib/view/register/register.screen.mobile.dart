import 'package:expense_tracker/controller/auth.controller.dart';
import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/view/login/widgets/app.name.text.dart';
import 'package:expense_tracker/view/login/widgets/auth.title.text.dart';
import 'package:expense_tracker/view/login/widgets/divider.dart';
import 'package:expense_tracker/view/login/widgets/footer.text.dart';
import 'package:expense_tracker/view/login/widgets/login.submit.button.dart';
import 'package:expense_tracker/view/login/widgets/mobile/have.an.account.container.mobile.dart';
import 'package:expense_tracker/view/login/widgets/social.media.sign.in/fb.sign.in.dart';
import 'package:expense_tracker/view/login/widgets/text.field.container.dart';
import 'package:expense_tracker/view/login/widgets/text.field.title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login/widgets/social.media.sign.in/google.sign.in.dart';

class RegisterScreenMobile extends StatefulWidget {
  const RegisterScreenMobile({Key? key}) : super(key: key);

  @override
  _RegisterScreenMobileState createState() => _RegisterScreenMobileState();
}

class _RegisterScreenMobileState extends State<RegisterScreenMobile>
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

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );

  @override
  void initState() {
    super.initState();
    // _googleSignIn = GoogleSignIn(
    //   scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
    // );
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

  final _formKey = GlobalKey<FormState>();
  FocusNode textSecondFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const opacityDuration = Duration(milliseconds: 900);
    const slideDuration = Duration(milliseconds: 400);

    return Scaffold(
      extendBody: true,
      body: Form(
        key: _formKey,
        child: Container(
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
                  height: 10,
                ),
                const AppNameText(),
                const SizedBox(height: 30),
                const AuthTitleText(title: 'Register'),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
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
                                width: double.infinity,
                                child: TextFormField(
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
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 15),
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldContainer(
                                      child: TextFormField(
                                        obscureText: !showPassword,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        onSaved: (val) {
                                          password = val.toString();
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    width: 43,
                                    margin: const EdgeInsets.only(
                                        left: 3, right: 13),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      child: Center(
                                        child: showPassword
                                            ? const Icon(
                                                Icons.visibility,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.visibility_off,
                                                color: Colors.black,
                                              ),
                                      ),
                                    ),
                                  )
                                ],
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
                                title: 'Register',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          const DividerText(),
                          const SizedBox(height: 10),
                                                     GoogleSignInButton(
                              title: 'Sign Up with Google', googleSignIn: _googleSignIn,),

                          const SizedBox(height: 10),
                          const FbSignInButton(title: 'Sign Up with facebook'),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const HaveAccoutContainerMobile(),
                const SizedBox(height: 20),
                const FooterText(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateAndProceed() async {
    _formKey.currentState!.save();
    AuthController.register(context, email.trim(), password.trim());
  }
}
