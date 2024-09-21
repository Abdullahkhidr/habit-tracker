import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/habit_editor_view.dart';

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
          appBarTheme: const AppBarTheme(titleTextStyle: TextStyles.h1),
          textTheme: GoogleFonts.cairoTextTheme(),
          colorScheme: const ColorScheme.light().copyWith(
              primary: kPrimaryColor,
              secondary: kSecondaryColor,
              onPrimary: kOnPrimaryColor,
              onSecondary: kOnSecondaryColor,
              error: kErrorColor)),
      home: const HabitEditorView(),
    );
  }
}

var _navigator = GlobalKey<NavigatorState>();

// Global Context
BuildContext get context => _navigator.currentContext!;
