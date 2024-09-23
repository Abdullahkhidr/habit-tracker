import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/custom_button_widget.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/color_palette_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/date_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/icon_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/repeat_section_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/select_type_of_habit_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/time_of_day_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/time_selector_widget.dart';

class HabitEditorViewBody extends StatelessWidget {
  const HabitEditorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HabitEditorBloc>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            leading: IconButton(
                onPressed: () => back(), icon: const Icon(Icons.close)),
            title: const Text('Create New Habit'),
            centerTitle: true),
        SliverToBoxAdapter(
          child: Padding(
              padding: kPaddingMedium.copyWith(top: kSpaceSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SelectTypeOfHabitWidget(),
                  const Gap(kSpaceLarge),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: kPaddingSmall.vertical),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Habit Title', style: TextStyles.h3),
                          const Gap(kSpaceSmall),
                          CustomFieldWidget(
                              hint: 'Habit Title',
                              controller: bloc.titleController),
                          const Gap(kSpaceSmall),
                          const Text('Description (Optional)',
                              style: TextStyles.h3),
                          const Gap(kSpaceSmall),
                          CustomFieldWidget(
                              hint: 'Description',
                              controller: bloc.descriptionController)
                        ],
                      )),
                  const Text('Icon', style: TextStyles.h3),
                  const IconSelectorWidget(),
                  const Text('Color', style: TextStyles.h3),
                  PaletteColorsWidget(
                      onColorSelected: (color) => bloc
                          .add(HabitEditorColorSelectedEvent(color: color))),
                  const RepeatSectionWidget(),
                  const Gap(kSpaceLarge),
                  const TimeOfDaySelectorWidget(),
                  const DueDateSelectorWidget(),
                  const TimeSelectorWidget(),
                  const Gap(kSpaceMedium),
                  CustomButtonWidget(
                      title: 'Save',
                      onTap: () => bloc.add(HabitEditorSaveEvent())),
                ],
              )),
        ),
      ],
    );
  }
}
