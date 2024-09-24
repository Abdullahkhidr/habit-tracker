import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/habit_editor_view_body.dart';

class HabitEditorView extends StatelessWidget {
  const HabitEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HabitEditorViewBody());
  }
}
