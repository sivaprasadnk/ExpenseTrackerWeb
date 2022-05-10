import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:blur/blur.dart';
import 'package:expense_tracker/api/repo/auth_repo.dart';
import 'package:expense_tracker/api/repo/user_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/view/windows/small/home/windows.small.home.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WindowsSmallLoginScreen extends StatefulWidget {
  const WindowsSmallLoginScreen({Key? key}) : super(key: key);

  @override
  _WindowsSmallLoginScreenState createState() =>
      _WindowsSmallLoginScreenState();
}

class _WindowsSmallLoginScreenState extends State<WindowsSmallLoginScreen> {
  String email = "";
  String password = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  // late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  // Key _inputKey = new GlobalKey(debugLabel: 'inputText');
  // static final _forKey1 = GlobalKey();
  // static final _forKey2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '1.0.0+10',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.7,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.cyan,
                    // ),
                    borderRadius: BorderRadius.circular(8),
                    // color: Colors.grey,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.05),
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // color: Colors.black,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                // key: _inputKey,
                                style: const TextStyle(color: Colors.black),
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
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.05),
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                obscureText: true,
                                style: const TextStyle(color: Colors.black),
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
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            validateAndProceed();
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ).frosted(
                  blur: 1,
                  borderRadius: BorderRadius.circular(20),
                  padding: const EdgeInsets.all(8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateAndProceed() async {
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
        AuthRepo().loginNew(email, password).then((response) async {
          if (response.status == ResponseStatus.error) {
            await showOkAlertDialog(
              context: context,
              title: 'Alert',
              message: response.message,
            );
          } else {
            String responseData = response.data;
            String dailyExpString = responseData.split('.').first;
            // String monthlyExpString = responseData.split('.').last;
            int dailyExp = int.parse(dailyExpString);
            // int monthlyExp = int.parse(monthlyExpString);
            if (mounted) {
              Provider.of<HomeProvider>(context, listen: false)
                  .updateDailyTotalExpense(dailyExp);
              // Provider.of<HomeProvider>(context, listen: false)
              //     .updateMonthlyTotal(monthlyExp);
              UserRepo().getRecentExpense().then((recentExpList) {
                Provider.of<HomeProvider>(context, listen: false)
                    .updateRecentList(recentExpList);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const WindowsSmallHome(),
                    ),
                    (r) => false);
              });
              // Future.delayed(Duration(seconds: 1)).then((value) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (ctx) => const WindowsSmallHome(),
              //     ),
              //   );
              // });
            }
          }
        });
      }
    }
  }
}
