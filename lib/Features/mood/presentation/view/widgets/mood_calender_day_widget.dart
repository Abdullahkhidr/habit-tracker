import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/mood/domain/entities/mood_entity.dart';
import 'package:habit_tracker/features/mood/domain/entities/mood_type.dart';
import 'package:hugeicons/hugeicons.dart';

class MoodCalenderDayWidget extends StatelessWidget {
  final DateTime date;
  final MoodEntity? moodEntity;
  final Function(DateTime)? onTap;
  const MoodCalenderDayWidget(
      {super.key, required this.date, this.moodEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(date),
      child: Padding(
        padding: kPaddingExtraSmall,
        child: Column(
          children: [
            if (moodEntity == null)
              Icon(HugeIcons.strokeRoundedSmile,
                  color: onTap == null ? kHintColor : kSecondaryColor,
                  size: 40.w)
            else
              Image.asset("assets/emojis/${moodEntity!.mood.emojiName}.png",
                  height: 40.w),
            Padding(
              padding: EdgeInsets.symmetric(vertical: kPaddingExtraSmall.top),
              child: Text(moodEntity?.mood.name ?? "Mood",
                  style: TextStyles.b5.copyWith(
                      fontSize: 9.w,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor)),
            ),
            Text(date.day.toString(),
                style: TextStyles.h5.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
