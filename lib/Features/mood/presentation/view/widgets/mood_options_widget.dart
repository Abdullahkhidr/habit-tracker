import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/custom_button_widget.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/mood/domain/entities/mood_type.dart';

class MoodOptionsWidget extends StatefulWidget {
  final Function(MoodType)? onSelect;
  const MoodOptionsWidget({super.key, this.onSelect});

  @override
  State<MoodOptionsWidget> createState() => _MoodOptionsWidgetState();
}

class _MoodOptionsWidgetState extends State<MoodOptionsWidget> {
  MoodType? _selectedMoodType;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: kPaddingMedium,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: MoodType.values
                    .map((e) => MoodOptionItemWidget(
                          moodType: e,
                          isSelected: e == _selectedMoodType,
                          onTap: () {
                            _selectedMoodType = e;
                            setState(() {});
                          },
                        ))
                    .toList()),
            if (_selectedMoodType != null)
              CustomButtonWidget(
                  title: 'Done',
                  onTap: () {
                    widget.onSelect?.call(_selectedMoodType!);
                    back();
                  },
                  borderRadius: kBorderRadiusMedium)
          ],
        ));
  }
}

class MoodOptionItemWidget extends StatelessWidget {
  final MoodType moodType;
  final bool isSelected;
  final Function() onTap;
  const MoodOptionItemWidget(
      {super.key,
      required this.moodType,
      required this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: kPaddingSmall,
          margin: kPaddingSmall,
          decoration: BoxDecoration(
            color: isSelected ? kPrimaryColor : null,
            borderRadius: kBorderRadiusMedium,
          ),
          child: Column(
            children: [
              Image.asset("assets/emojis/${moodType.emojiName}.png",
                  height: 75.w),
              Gap(kSpaceSmall),
              Text(moodType.name,
                  style: TextStyles.h3
                      .copyWith(color: isSelected ? kOnPrimaryColor : null)),
            ],
          )),
    );
  }
}
