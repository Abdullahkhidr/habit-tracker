import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/switch_widget.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class DueDateSelectorWidget extends StatelessWidget {
  const DueDateSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return Column(
      children: [
        SwitchWidget(
          title: 'End Habit On',
          value: bloc.habitEntity.dueDate != null,
          onChanged: (value) => bloc.add(HabitEditorDueDateSwitchEvent()),
        ),
        if (bloc.habitEntity.dueDate != null)
          CustomFieldWidget(
              readOnly: true,
              onTap: () => bloc.add(HabitEditorSelectDueDateEvent()),
              controller: TextEditingController(
                  text: DateFormat.yMMMMd().format(bloc.habitEntity.dueDate!)),
              hint: 'End Date',
              leadingIcon: HugeIcons.strokeRoundedCalendar03,
              trailingIcon: HugeIcons.strokeRoundedEdit02),
      ],
    );
  }
}
