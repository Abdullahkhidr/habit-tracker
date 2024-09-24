import 'package:flutter/material.dart';
import 'package:habit_tracker/features/Home/widgets/task_item_widget.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';

class CompletedTaskItemWidget extends StatelessWidget {
  final HabitEntity habitEntity;
  const CompletedTaskItemWidget({super.key, required this.habitEntity});

  @override
  Widget build(BuildContext context) {
    return TaskItemWidget(habitEntity: habitEntity, isCompleted: true);
  }
}
