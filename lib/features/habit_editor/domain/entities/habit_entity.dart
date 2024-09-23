import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:hive/hive.dart';

part 'habit_entity.g.dart';

@HiveType(typeId: 0)
class HabitEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  HabitType type;
  @HiveField(4)
  Color color;
  @HiveField(5)
  String icon;
  @HiveField(6)
  DateTime createdAt;
  @HiveField(7)
  DateTime? updatedAt;
  @HiveField(8)
  RepeatType repeatingType;
  @HiveField(9)
  Set<int> repeatingDays;
  @HiveField(10)
  PartOfDay partOfDay;
  @HiveField(11)
  DateTime? dueDate;
  @HiveField(12)
  TimeOfDay? remainder;

  HabitEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.icon,
      required this.type,
      required this.color,
      required this.createdAt,
      this.updatedAt,
      required this.repeatingType,
      required this.repeatingDays,
      required this.partOfDay,
      this.dueDate,
      this.remainder});

  factory HabitEntity.empty() => HabitEntity(
        id: '',
        title: '',
        description: '',
        icon: '',
        type: HabitType.regularHabit,
        color: Colors.blue,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        repeatingType: RepeatType.weekly,
        repeatingDays: {},
        partOfDay: PartOfDay.morning,
      );

  @override
  String toString() {
    return 'HabitEntity(id: $id, title: $title, description: $description, type: $type, color: $color, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt, repeatingType: $repeatingType, repeatingDays: $repeatingDays, partOfDay: $partOfDay, dueDate: $dueDate, remainder: $remainder)';
  }
}
