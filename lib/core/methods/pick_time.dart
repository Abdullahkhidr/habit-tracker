import 'package:flutter/material.dart';
import 'package:habit_tracker/main.dart';

Future<TimeOfDay?> pickTime([TimeOfDay? initTime]) async {
  var selectedTime = await showTimePicker(
      context: context, initialTime: initTime ?? TimeOfDay.now());
  return selectedTime;
}
