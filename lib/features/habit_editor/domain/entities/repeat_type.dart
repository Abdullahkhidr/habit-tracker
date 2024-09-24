import 'package:hive/hive.dart';

part 'repeat_type.g.dart';

@HiveType(typeId: 2)
enum RepeatType {
  @HiveField(0)
  weekly,
  @HiveField(1)
  monthly
}
