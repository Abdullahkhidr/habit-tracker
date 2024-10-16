import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/errors/failure.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/helpers/notifications_helper.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/methods/pick_date.dart';
import 'package:habit_tracker/core/methods/pick_time.dart';
import 'package:habit_tracker/core/methods/show_message.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/use_cases/create_habit_use_case.dart';
import 'package:habit_tracker/features/habit_editor/domain/use_cases/delete_habit_use_case.dart';
import 'package:habit_tracker/features/habit_editor/domain/use_cases/update_habit_use_case.dart';
import 'package:habit_tracker/features/home/manager/today/today_habits_cubit.dart';
import 'package:habit_tracker/features/home/manager/weekly/weekly_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'habit_editor_event.dart';
part 'habit_editor_state.dart';

class HabitEditorBloc extends Bloc<HabitEditorEvent, HabitEditorState> {
  final CreateHabitUseCase createHabitUseCase;
  final UpdateHabitUseCase updateHabitUseCase;
  final DeleteHabitUseCase deleteHabitUseCase;
  HabitEditorBloc(
      this.createHabitUseCase, this.updateHabitUseCase, this.deleteHabitUseCase)
      : super(HabitEditorInitial()) {
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
      emit(HabitEditorChangeRepeatingDaysState());
    });

    on<HabitEditorSaveEvent>((event, emit) async {
      habitEntity.title = titleController.text.trim();
      habitEntity.description = descriptionController.text.trim();
      if (!validation()) return;
      Either<Failure, void> result;
      if (isEdit) {
        result = await updateHabitUseCase(habitEntity);
        await removeNotification(habitEntity);
      } else {
        result = await createHabitUseCase(habitEntity);
      }
      result.fold((l) {
        showMessage('Error while saving',
            description: l.message, messageType: MessageType.error);
      }, (r) async {
        showMessage('Saved Successfully', messageType: MessageType.success);
        locator.get<TodayHabitsCubit>().loadHabits();
        locator.get<WeeklyCubit>().loadHabits();
        if (habitEntity.remainder != null) {
          await setNotification(habitEntity);
        }
      });
      back();
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
    on<HabitEditorDeleteEvent>((event, emit) async {
      var result = await deleteHabitUseCase(habitEntity);
      result.fold((l) {
        showMessage('Error while deleting',
            description: l.message, messageType: MessageType.error);
      }, (r) async {
        locator.get<TodayHabitsCubit>().loadHabits();
        locator.get<WeeklyCubit>().loadHabits();
        showMessage('Deleted Successfully', messageType: MessageType.success);
        await removeHistory(habitEntity);
        await removeNotification(habitEntity);
      });
      back();
    });
  }
  Future<void> removeHistory(HabitEntity habit) async {
    var box = Hive.box<HabitEntity>(HiveHelper.historyBox);
    var historyHabit = box.values.where((e) => e.id == habit.id).toList();
    historyHabit.forEach((habit) async {
      await box.delete("${habit.id}-${habit.createdAt.millisecondsSinceEpoch}");
    });
  }

  Future<void> setNotification(HabitEntity habitEntity) async {
    try {
      await notificationService.scheduleWeeklyNotification(
        id: habitEntity.id!,
        title: habitEntity.title,
        body: habitEntity.description,
        hour: habitEntity.remainder!.hour,
        minute: habitEntity.remainder!.minute,
        daysOfWeek: habitEntity.repeatingDays.toList(),
      );
    } catch (e) {
      showMessage('Error while setting notification',
          description: e.toString(), messageType: MessageType.error);
    }
  }

  Future<void> removeNotification(HabitEntity habitEntity) async {
    await notificationService.cancelWeeklyNotifications(habitEntity.id!);
  }

  bool validation() {
    if (titleController.text.trim().isEmpty) {
      showMessage('Title is required', messageType: MessageType.error);
      return false;
    }
    if (habitEntity.repeatingDays.isEmpty &&
        habitEntity.type == HabitType.regularHabit) {
      showMessage('Please select at least one day',
          messageType: MessageType.error);
      return false;
    }
    if (habitEntity.icon.isEmpty) {
      showMessage('please select icon', messageType: MessageType.error);
      return false;
    }
    return true;
  }

  bool _isEdit = false;

  void setHabitEntity(HabitEntity? habitEntity) {
    this.habitEntity = habitEntity?.copyWith() ?? HabitEntity.empty();
    titleController.text = this.habitEntity.title;
    descriptionController.text = this.habitEntity.description;
    _isEdit = habitEntity != null;
  }

  HabitEntity habitEntity = HabitEntity.empty();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool get isEdit => _isEdit;
  NotificationService notificationService = NotificationService();
}
