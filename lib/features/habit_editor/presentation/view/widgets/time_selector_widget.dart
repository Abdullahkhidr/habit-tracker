import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import 'switch_widget.dart';

class TimeSelectorWidget extends StatelessWidget {
  const TimeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return BlocListener<HabitEditorBloc, HabitEditorState>(
        listener: (context, state) {},
        listenWhen: (previous, current) =>
            current is HabitEditorSwitchRemainderState,
        child: Column(
          children: [
            SwitchWidget(
                title: 'Set Remainder',
                value: bloc.habitEntity.remainder != null,
                onChanged: (value) {
                  bloc.add(HabitEditorRemainderSwitchEvent());
                }),
            if (bloc.habitEntity.remainder != null)
              CustomFieldWidget(
                  onTap: () => bloc.add(HabitEditorSelectRemainderTimeEvent()),
                  readOnly: true,
                  controller: TextEditingController(
                      text: bloc.habitEntity.remainder!.format(context)),
                  hint: 'Time',
                  leadingIcon: HugeIcons.strokeRoundedTime03,
                  trailingIcon: HugeIcons.strokeRoundedEdit02),
          ],
        ));
  }
}
