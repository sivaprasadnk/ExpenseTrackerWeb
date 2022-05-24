import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:blur/blur.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/controller/login.controller.dart';
import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/view/login/widgets/login.submit.button.dart';
import 'package:expense_tracker/view/login/widgets/text.field.container.dart';
import 'package:expense_tracker/view/login/widgets/text.field.title.dart';
import 'package:expense_tracker/view/register/register.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const opacityDuration = Duration(milliseconds: 900);
    const slideDuration = Duration(milliseconds: 400);
    final ThemeNotifier theme =
        Provider.of<ThemeNotifier>(context, listen: true);
    var primaryColor = theme.themeData.primaryColor;
    return Scaffold(
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
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    kExpenseTrackerText + ' v1.1',
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
                    ).frosted(
                      blur: 1,
                      borderRadius: BorderRadius.circular(20),
                      padding: const EdgeInsets.all(8),
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
    if (email.isEmpty) {
      await showOkAlertDialog(
        context: context,
        title: 'Alert',
        message: 'Enter email',
      );
    } else {
      if (password.isEmpty) {
        await showOkAlertDialog(
          context: context,
          title: 'Alert',
          message: 'Enter Password',
        );
      } else {
        UserController.login(context, email, password);
        // Loading().showLoading(context);
        // AuthRepo().loginNew(email, password).then((response) async {
        //   if (response.status == ResponseStatus.error) {
        //     await showOkAlertDialog(
        //       context: context,
        //       title: 'Alert',
        //       message: response.message,
        //     ).then((value) {
        //       Navigator.pop(context);
        //     });
        //   } else {
        //     String responseData = response.data;
        //     String dailyExpString = responseData.split('.').first;
        //     int dailyExp = int.parse(dailyExpString);
        //     if (mounted) {
        //       Provider.of<HomeProvider>(context, listen: false)
        //           .updateDailyTotalExpense(dailyExp);
        //       UserRepo().getRecentExpense().then((recentExpList) {
        //         Provider.of<HomeProvider>(context, listen: false)
        //             .updateRecentList(recentExpList);

        //         Navigator.pushAndRemoveUntil(
        //             context,
        //             MaterialPageRoute(
        //               builder: (ctx) => const WindowsSmallHome(),
        //             ),
        //             (r) => false);
        //       });
        //     }
        //   }
        // });
      }
    }
  }
}
