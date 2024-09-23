part of 'habit_editor_bloc.dart';

@immutable
sealed class HabitEditorState {}

final class HabitEditorInitial extends HabitEditorState {}

final class HabitEditorColorSelectedState extends HabitEditorState {
  final Color color;
  HabitEditorColorSelectedState({required this.color});
}

final class HabitEditorSelectedTimeRemainderState extends HabitEditorState {
  final TimeOfDay time;
  HabitEditorSelectedTimeRemainderState({required this.time});
}

final class HabitEditorSelectedDueDateState extends HabitEditorState {
  final DateTime date;
  HabitEditorSelectedDueDateState({required this.date});
}

final class HabitEditorSelectedPartOfDayState extends HabitEditorState {
  final PartOfDay partOfDay;
  HabitEditorSelectedPartOfDayState({required this.partOfDay});
}

final class HabitEditorSwitchRemainderState extends HabitEditorState {
  final bool isOn;
  HabitEditorSwitchRemainderState({required this.isOn});
}

final class HabitEditorSwitchDueDateState extends HabitEditorState {
  final bool isOn;
  HabitEditorSwitchDueDateState({required this.isOn});
}

final class HabitEditorChangeRepeatTypeState extends HabitEditorState {
  final RepeatType repeatType;
  HabitEditorChangeRepeatTypeState({required this.repeatType});
}

final class HabitEditorChangeIconState extends HabitEditorState {
  final String icon;
  HabitEditorChangeIconState({required this.icon});
}
