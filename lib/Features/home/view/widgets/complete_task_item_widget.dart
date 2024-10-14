import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:hugeicons/hugeicons.dart';

import 'task_item_widget.dart';

class CompletedTaskItemWidget extends StatelessWidget {
  final HabitEntity habitEntity;
  final Function(HabitEntity)? onUndo;
  const CompletedTaskItemWidget(
      {super.key, required this.habitEntity, this.onUndo});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        startActionPane: TaskActionWidget(
            icon: HugeIcons.strokeRoundedArrowTurnBackward,
            action: () {
              onUndo?.call(habitEntity);
            },
            backgroundColor: kErrorColor),
        child: TaskItemWidget(habitEntity: habitEntity, isCompleted: true));
  }
}
