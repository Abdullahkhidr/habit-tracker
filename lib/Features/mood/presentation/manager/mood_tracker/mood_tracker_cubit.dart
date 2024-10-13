import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/features/mood/domain/entities/mood_entity.dart';
import 'package:habit_tracker/features/mood/presentation/view/widgets/mood_options_widget.dart';
import 'package:habit_tracker/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'mood_tracker_state.dart';

class MoodTrackerCubit extends Cubit<MoodTrackerState> {
  MoodTrackerCubit() : super(MoodTrackerInitial()) {
    loadMoods();
  }

  List<MoodEntity> moods = [];

  DateTime lastSelectedDate = DateTime.now();

  void loadMoods() {
    emit(MoodTrackerLoading());
    try {
      moods = Hive.box<MoodEntity>(HiveHelper.moodHistoryBox).values.toList();
      emit(MoodTrackerLoaded());
    } catch (e) {
      emit(MoodTrackerError(message: e.toString()));
    }
  }

  Future<void> setMood(DateTime date) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => MoodOptionsWidget(onSelect: (moodType) {
              moods.removeWhere((element) => element.date == date);
              moods.add(MoodEntity(date: date, mood: moodType));
              Hive.box<MoodEntity>(HiveHelper.moodHistoryBox)
                  .put(moods.last.date.toString(), moods.last);
            }));
    emit(MoodTrackerLoaded());
  }
}
