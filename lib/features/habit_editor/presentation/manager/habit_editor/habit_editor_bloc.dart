import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/methods/show_message.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/use_cases/create_habit_use_case.dart';
import 'package:habit_tracker/main.dart';
import 'package:meta/meta.dart';

part 'habit_editor_event.dart';
part 'habit_editor_state.dart';

class HabitEditorBloc extends Bloc<HabitEditorEvent, HabitEditorState> {
  final CreateHabitUseCase createHabitUseCase;
  HabitEditorBloc(this.createHabitUseCase) : super(HabitEditorInitial()) {
    on<HabitEditorEvent>((event, emit) {});

    on<HabitEditorColorSelectedEvent>((event, emit) {
      habitEntity.color = event.color;
      emit(HabitEditorColorSelectedState(color: event.color));
    });

    on<HabitEditorSelectRemainderTimeEvent>((event, emit) async {
      var selectedTime = await showTimePicker(
          context: context,
          initialTime: habitEntity.remainder ?? TimeOfDay.now());
      if (selectedTime != null) {
        habitEntity.remainder = selectedTime;
        emit(HabitEditorSelectedTimeRemainderState(time: selectedTime));
      }
    });

    on<HabitEditorSelectDueDateEvent>((event, emit) async {
      var selectedDate = await showDatePicker(
          context: context,
          initialDate: habitEntity.dueDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2500));
      if (selectedDate != null) {
        habitEntity.dueDate = selectedDate;
        emit(HabitEditorSelectedDueDateState(date: selectedDate));
      }
    });

    on<HabitEditorChangeIconEvent>((event, emit) {
      habitEntity.icon = event.icon;
      emit(HabitEditorChangeIconState(icon: event.icon));
    });

    on<HabitEditorRemainderSwitchEvent>((event, emit) {
      bool isOn = habitEntity.remainder != null;
      habitEntity.remainder = !isOn ? TimeOfDay.now() : null;
      emit(HabitEditorSwitchRemainderState(isOn: isOn));
    });

    on<HabitEditorDueDateSwitchEvent>((event, emit) {
      bool isOn = habitEntity.dueDate != null;
      habitEntity.dueDate = !isOn ? DateTime.now() : null;
      emit(HabitEditorSwitchDueDateState(isOn: isOn));
    });

    on<HabitEditorSelectPartOfDayEvent>((event, emit) {
      habitEntity.partOfDay = event.value;
      emit(HabitEditorSelectedPartOfDayState(partOfDay: event.value));
    });
    on<HabitEditorChangeRepeatTypeEvent>((event, emit) {
      habitEntity.repeatingType = event.value;
      habitEntity.repeatingDays.clear();
      emit(HabitEditorChangeRepeatTypeState(repeatType: event.value));
    });
    on<HabitEditorRepeatDaysSelectedEvent>((event, emit) {
      habitEntity.repeatingDays = event.days;
    });
    on<HabitEditorSaveEvent>((event, emit) async {
      habitEntity.title = titleController.text.trim();
      habitEntity.description = descriptionController.text.trim();
      if (!validation()) return;
      var result = await createHabitUseCase(habitEntity);
      result.fold((l) {
        showMessage('Error while saving',
            description: l.message, messageType: MessageType.error);
      }, (r) {
        showMessage('Saved Successfully', messageType: MessageType.success);
      });
    });
  }

  bool validation() {
    if (titleController.text.trim().isEmpty) {
      showMessage('Title is required', messageType: MessageType.error);
      return false;
    }
    if (habitEntity.repeatingDays.isEmpty) {
      showMessage('Please select at least one day',
          messageType: MessageType.error);
      return false;
    }
    return true;
  }

  HabitEntity habitEntity = HabitEntity.empty();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
}
