import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class DateTimeTaskSelectorWidget extends StatelessWidget {
  const DateTimeTaskSelectorWidget({
    super.key,
    required this.bloc,
  });

  final HabitEditorBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('When', style: TextStyles.h3),
        Gap(kSpaceSmall),
        CustomFieldWidget(
            onTap: () => bloc.add(HabitEditorSelectDateTimeOfOnTimeTaskEvent()),
            readOnly: true,
            controller: TextEditingController(
                text: DateFormat('yyyy-MM-dd – hh:mm a')
                    .format(bloc.habitEntity.when!)),
            hint: 'Time',
            leadingIcon: HugeIcons.strokeRoundedTime03,
            trailingIcon: HugeIcons.strokeRoundedEdit02),
      ],
    );
  }
}
