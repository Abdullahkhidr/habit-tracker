import 'package:get_it/get_it.dart';
import 'package:habit_tracker/features/habit_editor/data/data_source/local/local_data_source.dart';
import 'package:habit_tracker/features/habit_editor/data/repositories/habit_editor_repository_impl.dart';
import 'package:habit_tracker/features/habit_editor/domain/use_cases/create_habit_use_case.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';

GetIt get locator => GetIt.instance;

void setupLocator() {
  locator.registerSingleton(HabitEditorRepositoryImpl(
      habitEditorLocalDataSource: HabitEditorLocalDataSource()));
  locator.registerSingleton(HabitEditorBloc(CreateHabitUseCase(
      repository: locator.get<HabitEditorRepositoryImpl>())));
}
