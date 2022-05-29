// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool loggedIn = false;
//   bool get isLoggedIn => loggedIn;

//   void setUserStatus(bool status) {
//     loggedIn = status;
//     notifyListeners();
//   }

//   // create a getter stream
//   Stream<User?> get onAuthStateChanged => _auth.userChanges();

//   bool get userLoggedIn => _auth.currentUser != null;
//   //Sign in async functions here ..

// }
