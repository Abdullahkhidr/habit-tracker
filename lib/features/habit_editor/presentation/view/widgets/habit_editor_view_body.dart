import 'package:flutter/material.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/custom_button_widget.dart';
import 'package:habit_tracker/core/widgets/custom_field_widget.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/choose_days_of_month_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/color_palette_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/date_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/select_type_of_habit_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/switch_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/time_of_day_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/time_selector_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/type_of_repeat_selector_widget.dart';

class HabitEditorViewBody extends StatelessWidget {
  const HabitEditorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
              onPressed: () => back(), icon: const Icon(Icons.close)),
          title: const Text('Create New Habit'),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: kPaddingMedium.copyWith(top: kSpaceSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SelectTypeOfHabitWidget(),
                  const Gap(kSpaceLarge),
                  const Text('Habit Name', style: TextStyles.h3),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: kPaddingSmall.vertical),
                      child: const CustomFieldWidget(hint: 'Habit Name')),
                  const Text('Icon', style: TextStyles.h3),
                  const IconSelectorWidget(),
                  const Text('Color', style: TextStyles.h3),
                  const PaletteColorsWidget(),
                  const Text('Repeat', style: TextStyles.h3),
                  const Gap(kSpaceMedium),
                  const TypeOfRepeatSelectorWidget(),
                  const Gap(kSpaceMedium),
                  const ChooseDaysOfMonthWidget(),
                  const Gap(kSpaceLarge),
                  const Text('Do it at:', style: TextStyles.h3),
                  const TimeOfDaySelectorWidget(),
                  const SwitchWidget(title: 'End Habit On'),
                  DateSelectorWidget(initDate: DateTime.now()),
                  const SwitchWidget(title: 'Set Remainder'),
                  TimeSelectorWidget(timeOfDay: TimeOfDay.now()),
                  const Gap(kSpaceMedium),
                  CustomButtonWidget(title: 'Save', onTap: () {}),
                ],
              )),
        ),
      ],
    );
  }
}

class IconSelectorWidget extends StatelessWidget {
  const IconSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.from(emojis)
            .map((emoji) => EmojiIconWidget(emoji: emoji))
            .toList(),
      ),
    );
  }
}

class EmojiIconWidget extends StatelessWidget {
  final String emoji;
  const EmojiIconWidget({super.key, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: kPaddingSmall.copyWith(left: 0),
        padding: kPaddingSmall,
        decoration: BoxDecoration(
            borderRadius: kBorderRadiusSmall, border: Border.all(width: 0.5)),
        child: Text(emoji, style: const TextStyle(fontSize: 50)));
  }
}

const emojis = [
  '😀',
  '😃',
  '😄',
  '😁',
  '😆',
  '😅',
  '😂',
  '🤣',
  '🥲',
  '🥹',
  '😊',
  '😇',
  '🙂',
  '🙃',
  '😉',
  '😌',
  '😍',
  '🥰',
  '😘',
  '😗',
  '😙',
  '😚',
  '😋',
  '😛',
  '😝',
  '😜',
  '🤪',
  '🤨',
  '🧐',
  '🤓',
  '😎',
  '🥸',
  '🤩',
  '🥳',
  '🙂‍↕️',
  '😏',
  '😒',
  '🙂‍↔️',
  '😞',
  '😔',
  '😟',
  '😕',
  '🙁',
  '☹️',
  '😣',
  '😖',
  '😫',
  '😩',
  '🥺',
  '😢',
  '😭',
  '😮‍💨',
  '😤',
  '😠',
  '😡',
  '🤬',
  '🤯',
  '😳',
  '🥵',
  '🥶',
  '😱',
  '😨',
  '😰',
  '😥',
  '😓',
  '🫣',
  '🤗',
  '🫡',
  '🤔',
  '🫢',
  '🤭',
  '🤫',
  '🤥',
  '😶',
  '😶‍🌫️',
  '😐',
  '😑',
  '😬',
  '🫨',
  '🫠',
  '🙄',
  '😯',
  '😦',
  '😧',
  '😮',
  '😲',
  '🥱',
  '😴',
  '🤤',
  '😪',
  '😵',
  '😵‍💫',
  '🫥',
  '🤐',
  '🥴',
  '🤢',
  '🤮',
  '🤧',
  '😷',
  '🤒',
  '🤕',
  '🤑',
  '🤠',
  '😈',
  '👿',
  '👹',
  '👺',
  '🤡',
  '💩',
  '👻',
  '💀',
  '☠️',
  '👽',
  '👾',
  '🤖',
  '🎃',
  '😺',
  '😸',
  '😹',
  '😻',
  '😼',
  '😽',
  '🙀',
  '😿',
  '😾'
];
