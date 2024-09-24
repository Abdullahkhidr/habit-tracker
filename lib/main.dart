import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/app_bloc_observer.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/Home/layout/cubit/cubit.dart';
import 'package:habit_tracker/features/Home/layout/navigator_screen.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await HiveHelper.init();
  setupLocator();
  runApp(const ToastificationWrapper(child: HabitTracker()));
}

class HabitTracker extends StatelessWidget {
  const HabitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
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
            appBarTheme: const AppBarTheme(titleTextStyle: TextStyles.h1),
            textTheme: GoogleFonts.cairoTextTheme(),
            colorScheme: const ColorScheme.light().copyWith(
                primary: kPrimaryColor,
                secondary: kSecondaryColor,
                onPrimary: kOnPrimaryColor,
                onSecondary: kOnSecondaryColor,
                error: kErrorColor)),
        home: MultiBlocProvider(
          providers: [BlocProvider(create: (context) => HabitCubit())],
          child: const NavigatorScreen(),
        ),
      ),
    );
  }
}

var _navigator = GlobalKey<NavigatorState>();

// Global Context
BuildContext get context => _navigator.currentContext!;
