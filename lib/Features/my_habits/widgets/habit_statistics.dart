import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';

class HabitStatistics extends StatelessWidget {
  final HabitEntity habitEntity;
  const HabitStatistics({super.key, required this.habitEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: kPaddingMedium.left, horizontal: kPaddingExtraSmall.top),
      child: Column(
        children: [
          Row(
            children: [
              StatisticsCard(
                value: '226 days',
                label: 'Current streak',
                color: habitEntity.color,
              ),
              Gap(kSpaceSmall),
              StatisticsCard(
                  value: '95%',
                  label: 'Completion rate',
                  color: habitEntity.color),
            ],
          ),
          Gap(kSpaceSmall),
          Row(
            children: [
              StatisticsCard(
                  value: '459',
                  label: 'Habits completed',
                  color: habitEntity.color),
              Gap(kSpaceSmall),
              StatisticsCard(
                  value: '386',
                  label: 'Total perfect days',
                  color: habitEntity.color),
            ],
          ),
        ],
      ),
    );
  }
}

class StatisticsCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const StatisticsCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: kPaddingMedium,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kBorderRadiusSmall,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: kPaddingExtraSmall.left,
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyles.b1),
            Gap(kSpaceExtraSmall),
            Text(label, style: TextStyles.b4),
          ],
        ),
      ),
    );
  }
}
