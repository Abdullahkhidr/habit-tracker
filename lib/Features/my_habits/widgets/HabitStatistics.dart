import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class HabitStatistics extends StatelessWidget {
  const HabitStatistics({Key? key}) : super(key: key);

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
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      
      shape: RoundedRectangleBorder(
        borderRadius: kBorderRadiusMedium, // Use predefined border radius
      ),
      elevation: 2, // Add some elevation for better visibility
      child: Padding(
        padding: kPaddingSmall, // Use predefined padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center contents vertically
          children: [
            Text(value, style: TextStyles.b1), // Use custom text style for value
            Text(label, style: TextStyles.b4), // Use custom text style for label
          ],
        ),
      ),
    );
  }
}
