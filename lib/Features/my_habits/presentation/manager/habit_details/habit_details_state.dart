part of 'habit_details_cubit.dart';

sealed class HabitDetailsState extends Equatable {
  const HabitDetailsState();

  @override
  List<Object> get props => [];
}

final class HabitDetailsInitial extends HabitDetailsState {}

final class HabitDetailsLoaded extends HabitDetailsState {
  final List<DateTime> history;
  const HabitDetailsLoaded({required this.history});
}
