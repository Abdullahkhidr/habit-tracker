import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class TypeHabitSwitchWidget extends StatelessWidget {
  final HabitType habitType;
  final Function(HabitType type) onSelect;
  const TypeHabitSwitchWidget(
      {super.key, required this.habitType, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: OptionWidget(
              title: 'Regular Habit',
              isSelected: habitType == HabitType.regularHabit,
              onSelect: () => onSelect(HabitType.regularHabit))),
      Gap(kSpaceSmall),
      Expanded(
          child: OptionWidget(
              title: 'On-Time Task',
              isSelected: habitType == HabitType.oneTimeTask,
              onSelect: () => onSelect(HabitType.oneTimeTask))),
    ]);
  }
}

class TypeHabitSelectorWidget extends StatelessWidget {
  const TypeHabitSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return BlocListener<HabitEditorBloc, HabitEditorState>(
        listener: (context, state) {},
        listenWhen: (previous, current) =>
            current is HabitEditorChangedHabitTypeState,
        child: TypeHabitSwitchWidget(
          habitType: bloc.habitEntity.type,
          onSelect: (type) {
            bloc.add(HabitEditorChangeHabitTypeEvent(type: type));
          },
        ));
  }
}
