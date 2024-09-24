import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/methods/pick_date.dart';
import 'package:habit_tracker/core/methods/pick_time.dart';
import 'package:habit_tracker/core/methods/show_message.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/use_cases/create_habit_use_case.dart';
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
      TimeOfDay? selectedTime = await pickTime(habitEntity.remainder);
      if (selectedTime != null) {
        habitEntity.remainder = selectedTime;
        emit(HabitEditorSelectedTimeRemainderState(time: selectedTime));
      }
    });

    on<HabitEditorSelectDueDateEvent>((event, emit) async {
      DateTime? selectedDate = await pickDate(habitEntity.dueDate);
      if (selectedDate != null) {
        habitEntity.dueDate = selectedDate;
        emit(HabitEditorSelectedDueDateState(date: selectedDate));
      }
    });

    on<HabitEditorChangeHabitTypeEvent>((event, emit) {
      habitEntity.type = event.type;
      if (habitEntity.type == HabitType.oneTimeTask) {
        habitEntity.when = DateTime.now().add(const Duration(days: 1));
      }
      emit(HabitEditorChangedHabitTypeState(habitType: event.type));
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

    on<HabitEditorSelectDateTimeOfOnTimeTaskEvent>((event, emit) async {
      DateTime? selectedDate = await pickDate(habitEntity.when);
      if (selectedDate != null) {
        TimeOfDay? selectedTime =
            await pickTime(TimeOfDay.fromDateTime(habitEntity.when!));
        if (selectedTime != null) {
          DateTime when = DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedTime.hour, selectedTime.minute);
          habitEntity.when = when;
          emit(HabitEditorSelectDateTimeOfOnTimeTaskState(dateTime: when));
        }
      }
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
