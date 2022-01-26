import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expense_tracker/api/repo/auth_repo.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/view/android/home/android.home.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AndroidRegScreen extends StatefulWidget {
  const AndroidRegScreen({Key? key}) : super(key: key);

  @override
  _AndroidRegScreenState createState() => _AndroidRegScreenState();
}

class _AndroidRegScreenState extends State<AndroidRegScreen> {
  String email = "";
  String password = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: screenWidth * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.1),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.cyan,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
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
                        SizedBox(width: screenWidth * 0.1),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.cyan,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              obscureText: true,
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
                    ElevatedButton(
                      onPressed: () {
                        validateAndProceed();
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
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
        AuthRepo().createAccount(email, password).then((response) async {
          if (response.status == ResponseStatus.error) {
            await showOkAlertDialog(
              context: context,
              title: 'Alert',
              message: response.message,
            );
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => const AndroidHomeScreen()));
          }
        });
      }
    }
  }
}
