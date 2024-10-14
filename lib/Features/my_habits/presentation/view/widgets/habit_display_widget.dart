import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';

class HabitDisplayWidget extends StatelessWidget {
  final HabitEntity habitEntity;
  const HabitDisplayWidget({
    super.key,
    required this.habitEntity,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadiusSmall),
      tileColor: habitEntity.color,
      title: Text(habitEntity.title, style: TextStyles.h2),
      subtitle: habitEntity.description.trim().isEmpty
          ? null
          : Text(habitEntity.description, style: TextStyles.b5),
    );
  }
}
