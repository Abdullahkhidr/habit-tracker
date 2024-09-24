import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/color_adapter.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/time_of_day_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveHelper {
  static const String habitBox = 'habit_box';
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ColorAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
    Hive.registerAdapter(HabitTypeAdapter());
    Hive.registerAdapter(RepeatTypeAdapter());
    Hive.registerAdapter(PartOfDayAdapter());
    Hive.registerAdapter(HabitEntityAdapter());
    debugPrint((await Hive.openBox<HabitEntity>(habitBox)).values.join('\n'));
  }
}
