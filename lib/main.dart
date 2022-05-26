import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/provider/auth.provider.dart';
import 'package:expense_tracker/provider/cache_notifier.dart';
import 'package:expense_tracker/provider/dark.theme.provider.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/provider/route.provider.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/routes.dart';
import 'package:expense_tracker/view/windows.splash.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
//   try {

// // you can also assign this app to a FirebaseApp variable
// // for example app = await FirebaseApp.initializeApp...

//     await Firebase.initializeApp(
//       name: 'SecondaryApp',
//       options: firebaseOptions,
//     );
//   } on FirebaseException catch (e) {
//     if (e.code == 'duplicate-app') {
// // you can choose not to do anything here or either
// // In a case where you are assigning the initializer instance to a FirebaseApp variable, // do something like this:
// //
// //   app = Firebase.app('SecondaryApp');
// //
//     } else {
//       // ignore: use_rethrow_when_possible
//       throw e;
//     }
//   } catch (e) {
//     rethrow;
//   }
  // try {
  //   WidgetsFlutterBinding.ensureInitialized(); // Add this
  //   if (kIsWeb) {
  //     await Firebase.initializeApp(options: firebaseOptions);
  //   } else {
  //     // Firebase.app();
  // if (!kIsWeb) {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // }
  //   }
  //   // await Firebase.initializeApp(options: firebaseOptions);
  // } catch (e) {
  //   debugPrint(e.toString());
  // }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<DarkThemeProvider>(
            create: (_) => DarkThemeProvider()),
        ChangeNotifierProvider<CacheNotifier>(create: (_) => CacheNotifier()),
        ChangeNotifierProvider<RouteProvider>(
            create: (_) => RouteProvider(
                menuSelectedCheck: false, screenName: kLoginScreen))
      ],
      child: Consumer<ThemeNotifier>(
        builder: (_, provider, __) {
          return MaterialApp(
            title: 'Expense Tracker',
            debugShowCheckedModeBanner: false,
            routes: routes,
            theme: provider.themeData,
            home: const WindowsSplashScreen(),
          );
        },
      ),
    );
  }
}
