import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';

void main() {
  runApp(const HabitTracker());
}

class HabitTracker extends StatelessWidget {
  const HabitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          colorScheme: const ColorScheme.light().copyWith(
              primary: kPrimaryColor,
              secondary: kSecondaryColor,
              onPrimary: kOnPrimaryColor,
              onSecondary: kOnSecondaryColor,
              error: kErrorColor)),
      home: const Scaffold(),
    );
  }
}

var _navigator = GlobalKey<NavigatorState>();

// Global Context
BuildContext get context => _navigator.currentContext!;
