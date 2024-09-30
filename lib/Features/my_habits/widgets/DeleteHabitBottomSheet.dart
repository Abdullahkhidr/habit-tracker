import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class DeleteHabitBottomSheet extends StatelessWidget {
  final Function(bool keepHistory) onDelete;

  const DeleteHabitBottomSheet({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Delete Habit', style: TextStyles.h2), // Using TextStyles.h2 for the title
          const SizedBox(height: 10),
           Text(
            'Are you sure you want to delete this habit?',
            style: TextStyles.b4, // Using a body text style for the confirmation text
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: kErrorColor),
            title:  Text('Delete habit & keep history', style: TextStyles.b4), // Using TextStyles.b4 for the list item
            onTap: () {
              Navigator.of(context).pop();
              onDelete(true);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: kErrorColor),
            title:  Text('Delete habit & clear history', style: TextStyles.b4), // Using TextStyles.b4 for the list item
            onTap: () {
              Navigator.of(context).pop();
              onDelete(false);
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyles.b4), // Using TextStyles.b4 for the cancel button
          ),
        ],
      ),
    );
  }
}
