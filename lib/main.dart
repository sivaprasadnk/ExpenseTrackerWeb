import 'package:easy_localization/easy_localization.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/provider/cache_notifier.dart';
import 'package:expense_tracker/provider/dark.theme.provider.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:expense_tracker/provider/statistics.provider.dart';
import 'package:expense_tracker/provider/theme_notifier.dart';
import 'package:expense_tracker/routes.dart';
import 'package:expense_tracker/utils/network.service.dart';
import 'package:expense_tracker/view/splash.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // await FacebookAuth.i.webInitialize(
  //   appId: fbAppId,
  //   cookie: true,
  //   xfbml: true,
  //   version: "v13.0",
  // );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/mesh1.jpg"), context);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            StreamProvider<NetworkStatus>(
              create: (context) =>
                  NetworkStatusService().networkStatusController.stream,
              initialData: NetworkStatus.onLine,
            ),
            ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
            ChangeNotifierProvider<ThemeNotifier>(
                create: (_) => ThemeNotifier()),
            ChangeNotifierProvider<DarkThemeProvider>(
                create: (_) => DarkThemeProvider()),
            ChangeNotifierProvider<CacheNotifier>(
                create: (_) => CacheNotifier()),
            ChangeNotifierProvider<StatisticsProvider>(
                create: (_) => StatisticsProvider()),
          ],
          child: Consumer<ThemeNotifier>(
            builder: (_, provider, __) {
              return MaterialApp(
                title: 'Expense Tracker',
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: const [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                routes: routes,
                // onGenerateRoute: ,
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
      },
    );
  }
}
