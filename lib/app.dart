import 'package:flutter/material.dart';
import 'package:loot_vault/core/app_theme/app_theme.dart';
import 'package:loot_vault/view/homepage_view.dart';
import 'package:loot_vault/view/login_view.dart';
import 'package:loot_vault/view/onboarding_screen.dart';
import 'package:loot_vault/view/register_view.dart';

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => OnboardingScreen(),
        "/login": (context) => const LoginView(),
        "/register": (context) => const RegisterView(),
        "/home": (context) => const HomePageView(),
      },
      theme: getApplicationTheme(),
    );
  }
}
