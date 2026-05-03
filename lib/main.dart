import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/theme.dart';
import 'package:focus_planner/features/auth/presentation/screens/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus Planner',
      theme: AppTheme.darkThemeMode,
      home: const SignInScreen(),
    );
  }
}
