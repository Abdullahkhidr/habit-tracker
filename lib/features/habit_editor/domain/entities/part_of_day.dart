import 'package:hive/hive.dart';

part 'part_of_day.g.dart';

@HiveType(typeId: 3)
enum PartOfDay {
  @HiveField(0)
  morning,
  @HiveField(1)
  afternoon,
  @HiveField(2)
  evening
}
