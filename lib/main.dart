import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/provider/cache_notifier.dart';
import 'package:expense_tracker/provider/dark.theme.provider.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/routes.dart';
import 'package:expense_tracker/utils/network.service.dart';
import 'package:expense_tracker/view/splash.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   Future.delayed(const Duration(milliseconds: 500)).then((value) {
  //     FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //       if (user != null) {
  //         Navigation.checkPlatformAndNavigateToHome(context);
  //       } else {
  //         Navigator.pushNamed(context, LoginScreen.routeName);
  //       }
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/mesh1.jpg"), context);

    return MultiProvider(
      providers: [
        StreamProvider<NetworkStatus>(
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,
          initialData: NetworkStatus.onLine,
        ),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<DarkThemeProvider>(
            create: (_) => DarkThemeProvider()),
        ChangeNotifierProvider<CacheNotifier>(create: (_) => CacheNotifier()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (_, provider, __) {
          return MaterialApp(
            title: 'Expense Tracker',
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            routes: routes,
            theme: provider.themeData,
            // home: Consumer<AuthProvider>(
            //   builder: (_, auth, __) {
            //     return auth.isLoggedIn
            //         ? const SplashScreen()
            //         : const SplashScreen();
            //   },
            // )
            home: const SplashScreen(),
            // home: StreamBuilder(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (_, __) {
            //     return const SplashScreen();
            //   },
            // ),
          );
        },
      ),
    );
  }
}
