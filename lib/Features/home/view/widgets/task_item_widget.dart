import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:hugeicons/hugeicons.dart';

class TaskItemWidget extends StatelessWidget {
  final HabitEntity habitEntity;
  final bool isCompleted;
  const TaskItemWidget({
    super.key,
    required this.habitEntity,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadiusSmall),
      tileColor: isCompleted
          ? Color.lerp(kSuccessColor, Colors.white, 0.2)
          : habitEntity.color,
      contentPadding: kPaddingExtraSmall.copyWith(
          left: kPaddingMedium.left, right: kPaddingMedium.right),
      leading: Text(habitEntity.icon, style: TextStyle(fontSize: 30.sp)),
      title: Text(habitEntity.title,
          style:
              TextStyles.h3.copyWith(color: isCompleted ? Colors.white : null)),
      trailing: !isCompleted
          ? null
          : const Icon(HugeIcons.strokeRoundedTaskDone02, color: Colors.white),
    );
  }
}

class TaskActionWidget extends ActionPane {
  final Function() action;
  final Color backgroundColor;
  final IconData icon;
  TaskActionWidget(
      {super.key,
      required this.icon,
      required this.action,
      required this.backgroundColor})
      : super(extentRatio: 0.3, motion: const BehindMotion(), children: [
          SlidableAction(
              autoClose: true,
              onPressed: (context) => action(),
              backgroundColor: backgroundColor,
              borderRadius: kBorderRadiusSmall,
              foregroundColor: Colors.white,
              icon: icon),
        ]);
}
