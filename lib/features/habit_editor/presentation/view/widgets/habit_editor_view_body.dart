import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/custom_button_widget.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_type.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/color_palette_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/date_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/date_time_task_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/icon_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/repeat_section_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/time_of_day_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/time_selector_widget.dart';
import 'package:hugeicons/hugeicons.dart';

class HabitEditorViewBody extends StatefulWidget {
  final HabitEntity? habitEntity;
  const HabitEditorViewBody({super.key, this.habitEntity});

  @override
  State<HabitEditorViewBody> createState() => _HabitEditorViewBodyState();
}

class _HabitEditorViewBodyState extends State<HabitEditorViewBody> {
  @override
  void initState() {
    context.read<HabitEditorBloc>().setHabitEntity(widget.habitEntity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            leading: IconButton(
                onPressed: () => back(), icon: const Icon(Icons.close)),
            title: Text('${bloc.isEdit ? 'Edit' : 'Create New'} Habit'),
            actions: [
              if (bloc.isEdit)
                IconButton(
                    onPressed: () {
                      bloc.add(HabitEditorDeleteEvent());
                    },
                    icon: const Icon(HugeIcons.strokeRoundedDelete02,
                        color: kErrorColor))
            ],
            centerTitle: true),
        SliverToBoxAdapter(
          child: Padding(
              padding: kPaddingMedium.copyWith(top: kSpaceSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const TypeHabitSelectorWidget(),
                  const Divider(color: kHintColor),
                  Gap(kSpaceLarge),
                  const Text('Habit Title', style: TextStyles.h3),
                  Gap(kSpaceLarge),
                  CustomFieldWidget(
                      textInputAction: TextInputAction.next,
                      hint: 'Habit Title',
                      controller: bloc.titleController),
                  Gap(kSpaceSmall),
                  const Text('Description (Optional)', style: TextStyles.h3),
                  Gap(kSpaceSmall),
                  CustomFieldWidget(
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      hint: 'Description',
                      controller: bloc.descriptionController),
                  Gap(kSpaceLarge),
                  const Text('Icon', style: TextStyles.h3),
                  const IconSelectorWidget(),
                  const Text('Color', style: TextStyles.h3),
                  Gap(kSpaceMedium),
                  PaletteColorsWidget(
                      onColorSelected: (color) => bloc
                          .add(HabitEditorColorSelectedEvent(color: color))),
                  Gap(kSpaceLarge),
                  if (bloc.habitEntity.type == HabitType.regularHabit)
                    Column(
                      children: [
                        const RepeatSectionWidget(),
                        Gap(kSpaceLarge),
                        const TimeOfDaySelectorWidget(),
                        const DueDateSelectorWidget(),
                        const TimeSelectorWidget(),
                      ],
                    )
                  else
                    DateTimeTaskSelectorWidget(bloc: bloc),
                  Gap(kSpaceMedium),
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
