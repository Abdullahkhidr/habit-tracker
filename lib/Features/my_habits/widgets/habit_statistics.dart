import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class HabitStatistics extends StatelessWidget {
  const HabitStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        crossAxisSpacing: kSpaceSmall,
        mainAxisSpacing: kSpaceSmall,
      ),
      children: const [
        StatisticsCard(value: '226 days', label: 'Current streak'),
        StatisticsCard(value: '95%', label: 'Completion rate'),
        StatisticsCard(value: '459', label: 'Habits completed'),
        StatisticsCard(value: '386', label: 'Total perfect days'),
      ],
    );
  }
}

class StatisticsCard extends StatelessWidget {
  final String value;
  final String label;

  const StatisticsCard({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadiusMedium),
      elevation: 2,
      child: Padding(
        padding: kPaddingSmall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyles.b1),
            Text(label, style: TextStyles.b4),
          ],
        ),
      ),
    );
  }
}
