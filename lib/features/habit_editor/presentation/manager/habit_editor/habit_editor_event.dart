part of 'habit_editor_bloc.dart';

@immutable
sealed class HabitEditorEvent {}

class HabitEditorColorSelectedEvent extends HabitEditorEvent {
  final Color color;
  HabitEditorColorSelectedEvent({required this.color});
}

class HabitEditorChangeHabitTypeEvent extends HabitEditorEvent {
  final HabitType type;
  HabitEditorChangeHabitTypeEvent({required this.type});
}

class HabitEditorRemainderSwitchEvent extends HabitEditorEvent {}

class HabitEditorSelectRemainderTimeEvent extends HabitEditorEvent {}

class HabitEditorDueDateSwitchEvent extends HabitEditorEvent {}

class HabitEditorSelectDueDateEvent extends HabitEditorEvent {}

class HabitEditorChangeIconEvent extends HabitEditorEvent {
  final String icon;
  HabitEditorChangeIconEvent({required this.icon});
}

class HabitEditorSelectPartOfDayEvent extends HabitEditorEvent {
  final PartOfDay value;
  HabitEditorSelectPartOfDayEvent({required this.value});
}

class HabitEditorChangeRepeatTypeEvent extends HabitEditorEvent {
  final RepeatType value;
  HabitEditorChangeRepeatTypeEvent({required this.value});
}

class HabitEditorChangePartOfDayEvent extends HabitEditorEvent {
  final PartOfDay value;
  HabitEditorChangePartOfDayEvent({required this.value});
}

class HabitEditorRepeatDaysSelectedEvent extends HabitEditorEvent {
  final Set<int> days;
  HabitEditorRepeatDaysSelectedEvent({required this.days});
}

class HabitEditorSaveEvent extends HabitEditorEvent {}

class HabitEditorSelectDateTimeOfOnTimeTaskEvent extends HabitEditorEvent {}
