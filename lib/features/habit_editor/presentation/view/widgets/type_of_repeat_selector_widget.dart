import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class TypeOfRepeatSelectorWidget extends StatelessWidget {
  const TypeOfRepeatSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          _repeatType.length,
          (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: kPaddingSmall.right),
                  child: OptionWidget(
                      title: _repeatType[index],
                      isSelected: index == 0,
                      unSelectedBackgroundColor: kBackgroundColor,
                      borderRadius: kBorderRadiusCircular,
                      onSelect: () {}),
                ),
              )),
    );
  }
}

const _repeatType = ["Week", "Month"];
