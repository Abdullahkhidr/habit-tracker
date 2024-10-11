part of 'weekly_cubit.dart';

sealed class WeeklyState extends Equatable {
  const WeeklyState();

  @override
  List<Object> get props => [];
}

final class WeeklyInitial extends WeeklyState {}

final class WeeklyLoaded extends WeeklyState {
  final List<HabitEntity> habits;
  const WeeklyLoaded({required this.habits});

  @override
  List<Object> get props => [habits];
}
