import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/home/view/layout/navigator_screen.dart';
import 'package:habit_tracker/features/onboarding/view/onboarding_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hugeicons/hugeicons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();

    _next();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ScaleTransition(
                scale: _scaleAnimation,
                child: const Icon(
                  HugeIcons.strokeRoundedTask02,
                  size: 50,
                  color: kOnPrimaryColor,
                )),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text('Habit Tracker',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kOnPrimaryColor)),
            ),
            const Spacer(),
            Text('Out of Context',
                style: TextStyles.h5.copyWith(
                    color: kOnPrimaryColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void _next() async {
  Hive.openBox<dynamic>('settings').then((box) {
    Timer(const Duration(seconds: 3), () async {
      if (box.get('first_time', defaultValue: true)) {
        await box.put('first_time', false);
        replace(const OnboardingScreen());
      } else {
        replace(const NavigatorScreen());
      }
    });
  });
}
