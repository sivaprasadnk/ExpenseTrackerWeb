import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

    final FirebaseAuth _auth = FirebaseAuth.instance;

    // create a getter stream
    Stream<User?> get onAuthStateChanged => _auth.userChanges();

    //Sign in async functions here ..

}
