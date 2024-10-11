import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'weekly_state.dart';

class WeeklyCubit extends Cubit<WeeklyState> {
  WeeklyCubit() : super(WeeklyInitial());
  List<HabitEntity> habits = [];

  void loadHabits() {
    habits = Hive.box<HabitEntity>(HiveHelper.habitBox).values.toList();
    emit(WeeklyLoaded(habits: habits));
  }
}
