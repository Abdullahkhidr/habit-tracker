// import 'package:flutter/material.dart';
// import 'package:habit_tracker/Features/my_habits/EditHabitPage.dart';
// import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class HabitManager {
//   final BuildContext context;
//   final Box<HabitEntity> box;
//   List<HabitEntity> habits;

//   HabitManager({
//     required this.context,
//     required this.box,
//     required this.habits,
//   });

//   Future<void> editHabit(int index) async {
//     final updatedHabit = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditHabitPage(
//           habit: habits[index],
//           onHabitDeleted: () {
//             _deleteHabit(index);
//           },
//         ),
//       ),
//     );

//     if (updatedHabit != null) {
//       habits[index] = updatedHabit;
//       box.put(updatedHabit.id, updatedHabit); // Update the habit in the Hive box
//     }
//   }

//   void _deleteHabit(int index) {
//     box.delete(habits[index].id); // Delete from Hive
//     habits.removeAt(index); // Remove from local list
//     _showSnackBarMessage('Habit successfully deleted', success: true);
//   }

//   void _showSnackBarMessage(String message, {required bool success}) {
//     final snackBar = SnackBar(
//       content: Text(message),
//       backgroundColor: success ? Colors.green : Colors.red,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
