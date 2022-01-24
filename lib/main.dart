import 'package:expense_tracker/provider/route.provider.dart';
import 'package:expense_tracker/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this

  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyBIbJnZ4PhUD4mJ-eBpKeD9koJ-BJDWKtU",
      appId: "1:890691321939:web:f3d2d5ffcd6fc12ada86a6",
      messagingSenderId: "890691321939",
      projectId: "expensetrackerapp-9617f",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RouteProvider>.value(
            value: RouteProvider(menuSelectedCheck: false, screenName: "Home"))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
