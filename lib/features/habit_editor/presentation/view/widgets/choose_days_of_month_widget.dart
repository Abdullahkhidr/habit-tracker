import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class ChooseDaysOfMonthWidget extends StatelessWidget {
  const ChooseDaysOfMonthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPaddingMedium,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: kHintColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Every month on:',
              style: TextStyles.b3.copyWith(fontWeight: FontWeight.w500)),
          const Gap(kSpaceLarge),
          Wrap(
              runSpacing: kPaddingExtraSmall.vertical,
              spacing: kPaddingExtraSmall.horizontal,
              children: List.generate(
                  30,
                  (index) => SizedBox(
                        width: 40,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: OptionWidget(
                              padding: kPaddingExtraSmall,
                              borderRadius: kBorderRadiusCircular,
                              title: '${index + 1}',
                              isSelected: index & 2 == 0,
                              onSelect: () {}),
                        ),
                      ))),
        ],
      ),
    );
  }
}
