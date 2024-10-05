import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/methods/capitalize.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class TimeOfDaySelectorWidget extends StatelessWidget {
  const TimeOfDaySelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Do it at:', style: TextStyles.h3),
        Row(
          children: List.generate(
              PartOfDay.values.length,

              (index) => Expanded(
                    child: Padding(
                      padding:
                          (index != 0 && index != PartOfDay.values.length - 1)
                              ? kPaddingSmall
                              : EdgeInsets.zero,
                      child: OptionWidget(
                          title: PartOfDay.values[index].name.capitalize,
                          isSelected: bloc.habitEntity.partOfDay ==
                              PartOfDay.values[index],
                          unSelectedBackgroundColor: kBackgroundColor,
                          borderRadius: kBorderRadiusCircular,
                          onSelect: () => bloc.add(
                              HabitEditorSelectPartOfDayEvent(
                                  value: PartOfDay.values[index]))),
                    ),
                  )),
        ),
      ],
    );
  }
}
