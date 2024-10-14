import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'weekly_state.dart';

class WeeklyCubit extends Cubit<WeeklyState> {
  WeeklyCubit() : super(WeeklyInitial()) {
    loadHabits();
  }
  List<HabitEntity> habits = [];

  void loadHabits() {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    var box = Hive.box<HabitEntity>(HiveHelper.habitBox);
    habits = box.values.where((e) {
      return (e.dueDate == null || e.dueDate!.compareTo(now) >= 0);
    }).toList();
    emit(WeeklyLoaded(habits: habits));
  }
}
