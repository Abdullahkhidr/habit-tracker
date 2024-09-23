import 'package:flutter/material.dart';
import 'package:habit_tracker/main.dart';

Future<DateTime?> pickDate(DateTime? initDate,
    {DateTime? firstDate, DateTime? lastDate}) async {
  var selectedDate = await showDatePicker(
      context: context,
      initialDate: initDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime(2500));
  return selectedDate;
}
