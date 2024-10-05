import 'package:flutter/material.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';

class HabitDeletionHandler {
  final BuildContext context;
  final Function onHabitDeleted;

  HabitDeletionHandler({
    required this.context,
    required this.onHabitDeleted,
  });

  Future<void> deleteHabit({required bool keepHistory}) async {
    try {
      await _deleteHabitFromStorage();
      if (!keepHistory) await _deleteHabitHistory();
      onHabitDeleted(); // Notify parent widget about deletion
      _showSnackBarMessage('Habit successfully deleted', success: true);
      back();
    } catch (error) {
      _showSnackBarMessage('Error deleting habit', success: false);
    }
  }

  Future<void> _deleteHabitFromStorage() async {
    // Your logic to delete the habit from storage
    print("Habit deleted from storage.");
  }

  Future<void> _deleteHabitHistory() async {
    // Your logic to delete the habit history
    print("Habit history deleted from storage.");
  }

  void _showSnackBarMessage(String message, {required bool success}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor:
          success ? kSuccessColor : kErrorColor, // Use defined colors
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
