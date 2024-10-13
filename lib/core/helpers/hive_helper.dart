import 'package:habit_tracker/features/habit_editor/domain/entities/color_adapter.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/time_of_day_adapter.dart';
import 'package:habit_tracker/features/mood/domain/entities/mood_entity.dart';
import 'package:habit_tracker/features/mood/domain/entities/mood_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveHelper {
  static const String habitBox = 'habit_box';
  static const String historyBox = 'history_box';
  static const String moodHistoryBox = 'mood_history_box';
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ColorAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
    Hive.registerAdapter(HabitTypeAdapter());
    Hive.registerAdapter(RepeatTypeAdapter());
    Hive.registerAdapter(PartOfDayAdapter());
    Hive.registerAdapter(HabitEntityAdapter());
    Hive.registerAdapter(MoodEntityAdapter());
    Hive.registerAdapter(MoodTypeAdapter());
    await Hive.openBox<HabitEntity>(habitBox);
    await Hive.openBox<HabitEntity>(historyBox);
    await Hive.openBox<MoodEntity>(moodHistoryBox);
  }
}
