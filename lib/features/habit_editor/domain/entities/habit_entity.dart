import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/methods/generate_id.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:hive/hive.dart';

part 'habit_entity.g.dart';

@HiveType(typeId: 0)
class HabitEntity extends Equatable {
  @HiveField(0)
  int? id;
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
  @HiveField(13)
  DateTime? when;
  @HiveField(14)
  DateTime? completedAt;

  HabitEntity(
      {int? id,
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
      this.remainder,
      this.when,
      this.completedAt}) {
    this.id = id ?? generateId();
  }

  factory HabitEntity.empty() => HabitEntity(
        id: generateId(),
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
        when: null,
        completedAt: null,
      );

  HabitEntity copyWith({
    int? id,
    String? title,
    String? description,
    HabitType? type,
    DateTime? when,
    Color? color,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
    RepeatType? repeatingType,
    Set<int>? repeatingDays,
    PartOfDay? partOfDay,
    DateTime? dueDate,
    TimeOfDay? remainder,
    DateTime? completedAt,
  }) {
    return HabitEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      when: when ?? this.when,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      repeatingType: repeatingType ?? this.repeatingType,
      repeatingDays: repeatingDays ?? this.repeatingDays,
      partOfDay: partOfDay ?? this.partOfDay,
      dueDate: dueDate ?? this.dueDate,
      remainder: remainder ?? this.remainder,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  String toString() {
    return 'HabitEntity(id: $id, title: $title, description: $description, type: $type, when: $when , color: $color, icon: $icon, createdAt: $createdAt, updatedAt: $updatedAt, repeatingType: $repeatingType, repeatingDays: $repeatingDays, partOfDay: $partOfDay, dueDate: $dueDate, remainder: $remainder, completedAt: $completedAt)';
  }

  @override
  List<Object?> get props => [id];
}
