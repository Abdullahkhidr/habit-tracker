import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitEditorLocalDataSource {
  Future<void> createHabit(HabitEntity habitEntity) async {
    await Hive.box<HabitEntity>(HiveHelper.habitBox).add(habitEntity);
  }
}
