import 'package:hive/hive.dart';

part 'habit_type.g.dart';

@HiveType(typeId: 1)
enum HabitType {
  @HiveField(0)
  regularHabit,
  @HiveField(1)
  oneTimeTask
}
