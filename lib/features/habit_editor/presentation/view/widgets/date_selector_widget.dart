import 'package:flutter/material.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:hugeicons/hugeicons.dart';

class DateSelectorWidget extends StatelessWidget {
  final DateTime initDate;
  const DateSelectorWidget({super.key, required this.initDate});

  @override
  Widget build(BuildContext context) {
    return CustomFieldWidget(
        controller: TextEditingController(text: initDate.toIso8601String()),
        hint: 'End Date',
        leadingIcon: HugeIcons.strokeRoundedCalendar03,
        trailingIcon: HugeIcons.strokeRoundedEdit02);
  }
}
