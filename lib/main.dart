import 'package:flutter/material.dart';
import 'package:login_api/helpers/dependencie_injection.dart';
import 'package:login_api/pages/home_page.dart';
import 'package:login_api/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:login_api/pages/page.dart';
import 'package:login_api/pages/register_page.dart';

void main() {
  DepedencyInjection.initialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        RegisterPage.routeName: (_) => const RegisterPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        HomePage.routeName: (_) => const HomePage(),
      },
    );
  }
}

