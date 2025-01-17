import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/core/theme/app_theme.dart';
import 'package:loot_vault/features/onboarding/presentation/view/onboarding_screen.dart';
import 'package:loot_vault/features/onboarding/presentation/view_model/onboarding_cubit.dart';

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => getIt<OnboardingCubit>(),
        child: OnboardingScreen(),
      ),
      theme: getApplicationTheme(),
    );
  }
}
