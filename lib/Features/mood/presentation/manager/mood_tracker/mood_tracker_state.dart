part of 'mood_tracker_cubit.dart';

sealed class MoodTrackerState {
  const MoodTrackerState();
}

final class MoodTrackerInitial extends MoodTrackerState {}

final class MoodTrackerLoading extends MoodTrackerState {}

final class MoodTrackerLoaded extends MoodTrackerState {}

final class MoodTrackerError extends MoodTrackerState {
  final String message;
  const MoodTrackerError({required this.message});
}
