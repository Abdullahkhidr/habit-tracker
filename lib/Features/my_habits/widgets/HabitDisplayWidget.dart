import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:habit_tracker/core/widgets/gap.dart';

class HabitDisplayWidget extends StatelessWidget {
  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String habitTitle; 
  final String habitDescription; 
  //final IconData habitIcon; // Add this line to receive the icon

  const HabitDisplayWidget({
    Key? key,
    required this.isEditing,
    required this.titleController,
    required this.descriptionController,
    required this.habitTitle,
    required this.habitDescription,
   // required this.habitIcon, // Add this line to accept the icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(kSpaceMedium), // Use defined space constants
          const Text('Habit Title', style: TextStyles.h3),
          Gap(kSpaceMedium),
          CustomFieldWidget(
            textInputAction: TextInputAction.next,
            hint: 'Habit Title',
            controller: titleController,
          ),
          Gap(kSpaceSmall),
          const Text('Description (Optional)', style: TextStyles.h3),
          Gap(kSpaceSmall),
          CustomFieldWidget(
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            hint: 'Description',
            controller: descriptionController,
          ),
        //Gap(kSpaceMedium),
        ],
      );
    } else {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadiusLarge, // Use defined border radius
        ),
        child: ListTile(
         // leading: Icon(habitIcon, color: kPrimaryColor), // Use primary color for icon
          title: Text(habitTitle, style: TextStyles.h4), // Display the habit title with style
          subtitle: Text(
            habitDescription.isNotEmpty ? habitDescription : 'Everyday', 
            style: TextStyles.b4, // Use body text style for subtitle
          ), // Display description or fallback text
        ),
      );
    }
  }
}
