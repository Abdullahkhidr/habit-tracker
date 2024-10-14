import 'package:bloc/bloc.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'today_habits_state.dart';

class TodayHabitsCubit extends Cubit<TodayHabitsState> {
  TodayHabitsCubit() : super(TodayHabitsInitial()) {
    loadHabits();
  }

  List<HabitEntity> _habits = [];
  PartOfDay? partOfDay;

  void taskCompleted(HabitEntity habit) {
    DateTime now = DateTime.now();
    Box<HabitEntity> box = Hive.box<HabitEntity>(HiveHelper.historyBox);
    habit.completedAt = DateTime(now.year, now.month, now.day);
    box.put("${habit.id}-${habit.completedAt!.millisecondsSinceEpoch}", habit);
    loadHabits();
    emit(TodayHabitsTaskCompleted(habit));
  }

  void filterByPartOfDay(PartOfDay? partOfDay) {
    this.partOfDay = partOfDay;
    emit(TodayHabitsFilterByPartOfDay(partOfDay));
  }

  void undoTask(HabitEntity habit) {
    Box<HabitEntity> box = Hive.box<HabitEntity>(HiveHelper.historyBox);
    box.delete("${habit.id}-${habit.completedAt!.millisecondsSinceEpoch}");
    _habits[_habits.indexOf(habit)].completedAt = null;
    emit(TodayHabitsTaskUndone(habit));
  }

  void loadHabits() {
    emit(TodayHabitsLoading());
    try {
      DateTime now = DateTime.now();
      now = DateTime(now.year, now.month, now.day);
      Box<HabitEntity> box = Hive.box<HabitEntity>(HiveHelper.habitBox);
      var completedTasks = _fetchCompletedTasks();
      _habits = box.values.where((e) {
        return e.repeatingDays.contains(now.weekday) &&
            (e.dueDate == null || e.dueDate!.compareTo(now) >= 0);
      }).toList();
      _habits.forEach((habit) {
        if (completedTasks.contains(habit)) {
          habit.completedAt = DateTime(now.year, now.month, now.day);
        }
      });
      emit(TodayHabitsLoaded(_habits));
    } catch (error) {
      emit(TodayHabitsError(error.toString()));
    }
  }

  List<HabitEntity> _fetchCompletedTasks() {
    DateTime now = DateTime.now();
    Box<HabitEntity> historyBox = Hive.box<HabitEntity>(HiveHelper.historyBox);
    return historyBox.values
        .where((habit) =>
            habit.completedAt == DateTime(now.year, now.month, now.day))
        .toList();
  }

  List<HabitEntity> get habits {
    if (partOfDay != null) {
      return _habits.where((habit) => habit.partOfDay == partOfDay).toList();
    }
    return _habits;
  }

  List<HabitEntity> get completedHabits {
    return habits.where((habit) => habit.completedAt != null).toList();
  }

  List<HabitEntity> get inCompletedHabits {
    return habits.where((habit) => habit.completedAt == null).toList();
  }
}
