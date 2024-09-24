import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Features/Home/layout/cubit/cubit.dart';
import 'Features/Home/layout/navigator_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HabitCubit>(
          create: (context) => HabitCubit(),
        ),
      ],
      child: const HabitTracker(),
    ),
  );
}

class HabitTracker extends StatelessWidget {
  const HabitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: _navigator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: kOnPrimaryColor,
            ),
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kBackgroundColor,
            colorScheme: const ColorScheme.light().copyWith(
              primary: kPrimaryColor,
              secondary: kSecondaryColor,
              onPrimary: kOnPrimaryColor,
              onSecondary: kOnSecondaryColor,
              error: kErrorColor,
            ),
          ),
          home: const NavigatorScreen(),
        );
      },
    );
  }
}

var _navigator = GlobalKey<NavigatorState>();

// Global Context
BuildContext get context => _navigator.currentContext!;
