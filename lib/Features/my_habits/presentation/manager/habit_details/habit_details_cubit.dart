import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/methods/get_date_from_datetime.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'habit_details_state.dart';

class HabitDetailsCubit extends Cubit<HabitDetailsState> {
  final HabitEntity habit;
  HabitDetailsCubit(this.habit) : super(HabitDetailsInitial()) {
    getHabitsDetails(habit);
    numberOfDays = _numberOfDays();
  }

  List<DateTime> history = [];
  late ({int all, int completed, List<int> streaks}) numberOfDays;
  int get currentStreak => numberOfDays.streaks.last;
  double get completionRate =>
      numberOfDays.all == 0 ? 0 : numberOfDays.completed / numberOfDays.all;

  void getHabitsDetails(HabitEntity habit) {
    var box = Hive.box<HabitEntity>(HiveHelper.historyBox);
    history = box.values
        .where((e) => e.id == habit.id)
        .map((e) => e.createdAt.date)
        .toList();
    emit(HabitDetailsLoaded(history: history));
  }

  ({int all, int completed, List<int> streaks}) _numberOfDays() {
    var startDate = habit.createdAt.date;
    var now = DateTime.now().date;
    int totalDays = 0;
    int completedDays = 0;
    List<int> streaks = [0];
    while (!startDate.isAfter(now)) {
      if (habit.repeatingDays.contains(startDate.weekday)) {
        totalDays++;
        if (history.contains(startDate)) {
          completedDays++;
          streaks.add(streaks.last + 1);
        } else if (streaks.last != 0) {
          streaks.add(0);
        }
      }
      startDate = startDate.add(const Duration(days: 1));
    }
    print('Streaks $streaks');
    if (totalDays == 0) return (all: 0, completed: 0, streaks: streaks);
    return (all: totalDays, completed: completedDays, streaks: streaks);
  }
}
