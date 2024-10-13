import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class CustomMoodViewAppBar extends StatelessWidget {
  const CustomMoodViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingMedium,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Mood Stat', style: TextStyles.h1),
        ],
      ),
    );
  }
}
