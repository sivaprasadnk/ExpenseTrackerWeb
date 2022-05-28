import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/provider/auth.provider.dart';
import 'package:expense_tracker/provider/cache_notifier.dart';
import 'package:expense_tracker/provider/dark.theme.provider.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/routes.dart';
import 'package:expense_tracker/view/splash.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/mesh1.jpg"), context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<DarkThemeProvider>(
            create: (_) => DarkThemeProvider()),
        ChangeNotifierProvider<CacheNotifier>(create: (_) => CacheNotifier()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (_, provider, __) {
          return MaterialApp(
            title: 'Expense Tracker',
            debugShowCheckedModeBanner: false,
            routes: routes,
            theme: provider.themeData,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
