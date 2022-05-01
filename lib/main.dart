import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/provider/route.provider.dart';
import 'package:expense_tracker/routes.dart';
import 'package:expense_tracker/view/windows/windows.splash.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<RouteProvider>(
            create: (_) => RouteProvider(
                menuSelectedCheck: false, screenName: kLoginScreen))
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        // home: defaultTargetPlatform == TargetPlatform.iOS ||
        //         defaultTargetPlatform == TargetPlatform.iOS
        //     ? const AndroidSplashScreen()
        //     : const WindowsSplashScreen(),
        home: const WindowsSplashScreen(),
      ),
    );
  }
}
