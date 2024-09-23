import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/methods/capitalize.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class TypeOfRepeatSelectorWidget extends StatelessWidget {
  const TypeOfRepeatSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return BlocListener<HabitEditorBloc, HabitEditorState>(
      listener: (context, state) {},
      listenWhen: (previous, current) =>
          current is HabitEditorChangeRepeatTypeState,
      child: Row(
        children: List.generate(
            RepeatType.values.length,
            (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: kPaddingSmall.right),
                    child: OptionWidget(
                        title: RepeatType.values[index].name.capitalize,
                        isSelected: bloc.habitEntity.repeatingType ==
                            RepeatType.values[index],
                        unSelectedBackgroundColor: kBackgroundColor,
                        borderRadius: kBorderRadiusCircular,
                        onSelect: () {
                          bloc.add(HabitEditorChangeRepeatTypeEvent(
                              value: RepeatType.values[index]));
                        }),
                  ),
                )),
      ),
    );
  }
}
