import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Focus Planner',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppPallete.accentColor1,
          ),
        ),
      ),
    );
  }
}
