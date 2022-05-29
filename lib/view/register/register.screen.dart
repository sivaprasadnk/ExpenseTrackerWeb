import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/controller/user.controller.dart';
import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/utils/dialog.dart';
import 'package:expense_tracker/view/login/login.screen.dart';
import 'package:expense_tracker/view/login/widgets/login.submit.button.dart';
import 'package:expense_tracker/view/login/widgets/text.field.container.dart';
import 'package:expense_tracker/view/login/widgets/text.field.title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
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
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
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
      bottomNavigationBar: const Text(
        kCopyRightText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(0, 24, 88, 1),
        ),
      ),
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
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    kExpenseTrackerText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
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
                        'Register',
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
                                  style: const TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    // fontFamily: 'Rajdhani',
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
                                child: TextFormField(
                                  obscureText: true,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    // fontFamily: 'Rajdhani',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onSaved: (val) {
                                    password = val.toString();
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
                          Center(
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
                                      // color: primaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const LoginScreen()));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateAndProceed() async {
    _formKey.currentState!.save();
    if (email.trim().isEmpty) {
      Dialogs.showAlertDialog(context: context, title: 'Enter email !');
    } else {
      if (password.trim().isEmpty) {
        Dialogs.showAlertDialog(context: context, title: 'Enter password !');
      } else {
        UserController.register(context, email.trim(), password.trim());
      }
    }
  }
}
