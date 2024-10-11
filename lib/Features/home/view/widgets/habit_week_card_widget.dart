import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';

class HabitWeekCardWidget extends StatelessWidget {
  final HabitEntity habit;
  const HabitWeekCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPaddingLarge,
      margin: EdgeInsets.only(top: kPaddingSmall.vertical),
      decoration: BoxDecoration(
          color: kBackgroundColor,
          border: Border.all(color: habit.color, width: 0.5.w),
          borderRadius: kBorderRadiusMedium,
          boxShadow: [
            BoxShadow(color: habit.color, blurRadius: 5.w, spreadRadius: 0.4.w)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                habit.title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: kOnSecondaryColor,
                ),
              ),
              const Spacer(),
              Text(
                "${habit.repeatingDays.length} days per week",
                style: const TextStyle(color: kSecondaryColor),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            height: 1,
            color: kHintColor,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              return Column(
                children: [
                  Text(
                    _days[index],
                    style: const TextStyle(
                      color: kSecondaryColor,
                    ),
                  ),
                  Container(
                    width: 33.w,
                    height: 33.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: habit.repeatingDays.contains(index + 1)
                          ? habit.color
                          : Colors.transparent,
                      border: Border.all(color: habit.color, width: 1.w),
                    ),
                    child: habit.repeatingDays.contains(index + 1)
                        ? Icon(FontAwesomeIcons.check,
                            color: kBackgroundColor, size: 16.sp)
                        : null,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

List<String> _days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
