import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/habit_editor_view_body.dart';

class HabitEditorView extends StatelessWidget {
  final HabitEntity? habitEntity;
  const HabitEditorView({super.key, this.habitEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HabitEditorViewBody(habitEntity: habitEntity));
  }
}
