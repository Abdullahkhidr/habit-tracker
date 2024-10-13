import 'package:equatable/equatable.dart';
import 'package:habit_tracker/features/mood/domain/entities/mood_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'mood_entity.g.dart';

@HiveType(typeId: 50)
class MoodEntity extends Equatable {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final MoodType mood;

  const MoodEntity({required this.date, required this.mood});

  @override
  String toString() {
    return "Date: $date, Mood: $mood";
  }

  @override
  List<Object?> get props => [date, mood];
}
