import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/app_bloc_observer.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/data/data_source/local/local_data_source.dart';
import 'package:habit_tracker/features/habit_editor/data/repositories/habit_editor_repository_impl.dart';
import 'package:habit_tracker/features/habit_editor/domain/use_cases/create_habit_use_case.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/habit_editor_view.dart';
import 'package:toastification/toastification.dart';

import 'features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await HiveHelper.init();
  runApp(const ToastificationWrapper(child: HabitTracker()));
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
      home: BlocProvider(
        create: (context) => HabitEditorBloc(CreateHabitUseCase(
            repository: HabitEditorRepositoryImpl(
                habitEditorLocalDataSource: HabitEditorLocalDataSource()))),
        child: const HabitEditorView(),
      ),
    );
  }
}

var _navigator = GlobalKey<NavigatorState>();

// Global Context
BuildContext get context => _navigator.currentContext!;
