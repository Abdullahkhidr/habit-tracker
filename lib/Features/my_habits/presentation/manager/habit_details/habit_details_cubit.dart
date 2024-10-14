import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'habit_details_state.dart';

class HabitDetailsCubit extends Cubit<HabitDetailsState> {
  HabitDetailsCubit(HabitEntity habit) : super(HabitDetailsInitial()) {
    getHabitsDetails(habit);
  }

  List<DateTime> history = [];

  void getHabitsDetails(HabitEntity habit) {
    var box = Hive.box<HabitEntity>(HiveHelper.historyBox);
    history = box.values
        .where((e) => e.id == habit.id)
        .map((e) => e.completedAt!)
        .toList();
    emit(HabitDetailsLoaded(history: history));
  }
}
