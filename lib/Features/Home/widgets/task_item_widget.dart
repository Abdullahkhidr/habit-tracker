import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/utils/constants.dart';

class TaskItemWidget extends StatelessWidget {
  final String label;
  final Color color;

  const TaskItemWidget({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        contentPadding: kPaddingExtraSmall.copyWith(
            left: kPaddingMedium.left, right: kPaddingMedium.right),
        title: Text(
          label,
          style: TextStyle(
            color: kTextColor,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
