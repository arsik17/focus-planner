import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppPallete.primaryColor,
      ),
    );
  }
}

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppPallete.primaryColor,
      ),
    );
  }
}
