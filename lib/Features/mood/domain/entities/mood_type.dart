import 'package:hive_flutter/hive_flutter.dart';

part 'mood_type.g.dart';

@HiveType(typeId: 51)
enum MoodType {
  @HiveField(0)
  great,
  @HiveField(1)
  smile,
  @HiveField(2)
  normal,
  @HiveField(3)
  sad,
  @HiveField(4)
  angry,
}

extension MoodTypeExtension on MoodType {
  String get name {
    switch (this) {
      case MoodType.great:
        return "Great";
      case MoodType.smile:
        return "Smile";
      case MoodType.normal:
        return "Normal";
      case MoodType.sad:
        return "Sad";
      case MoodType.angry:
        return "Angry";
    }
  }

  String get emojiName {
    switch (this) {
      case MoodType.great:
        return "great";
      case MoodType.smile:
        return "smile";
      case MoodType.normal:
        return "normal";
      case MoodType.sad:
        return "sad";
      case MoodType.angry:
        return "angry";
    }
  }
}
