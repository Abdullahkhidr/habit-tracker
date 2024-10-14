part of 'today_habits_cubit.dart';

@immutable
sealed class TodayHabitsState {
  const TodayHabitsState();
}

final class TodayHabitsInitial extends TodayHabitsState {}

final class TodayHabitsLoading extends TodayHabitsState {}

final class TodayHabitsLoaded extends TodayHabitsState {
  final List<HabitEntity> habits;

  const TodayHabitsLoaded(this.habits);
}

final class TodayHabitsError extends TodayHabitsState {
  final String message;

  const TodayHabitsError(this.message);
}

final class TodayHabitsTaskCompleted extends TodayHabitsState {
  final HabitEntity habit;

  const TodayHabitsTaskCompleted(this.habit);
}

final class TodayHabitsFilterByPartOfDay extends TodayHabitsState {
  final PartOfDay? partOfDay;

  const TodayHabitsFilterByPartOfDay(this.partOfDay);
}

final class TodayHabitsTaskUndone extends TodayHabitsState {
  final HabitEntity habit;

  const TodayHabitsTaskUndone(this.habit);
}
