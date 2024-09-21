import 'package:flutter/material.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:hugeicons/hugeicons.dart';

class TimeSelectorWidget extends StatelessWidget {
  final TimeOfDay timeOfDay;
  const TimeSelectorWidget({super.key, required this.timeOfDay});

  @override
  Widget build(BuildContext context) {
    return CustomFieldWidget(
        controller: TextEditingController(text: timeOfDay.format(context)),
        hint: 'Time',
        leadingIcon: HugeIcons.strokeRoundedTime03,
        trailingIcon: HugeIcons.strokeRoundedEdit02);
  }
}
