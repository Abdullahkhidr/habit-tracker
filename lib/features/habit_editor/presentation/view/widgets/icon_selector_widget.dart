import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/emoji_icon_widget.dart';

class IconSelectorWidget extends StatefulWidget {
  const IconSelectorWidget({super.key});

  @override
  State<IconSelectorWidget> createState() => _IconSelectorWidgetState();
}

class _IconSelectorWidgetState extends State<IconSelectorWidget> {
  var emojis = [
    'baseball',
    'basketball',
    'boxing_glove',
    'cooking',
    'football',
    'goal',
    'golf_club',
    'gym',
    'laptop',
    'medal',
    'open_book',
    'rugby_ball',
    'skate',
    'tennis',
    'tree',
    'trophy',
    'volleyball',
  ];
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.from(emojis)
            .map((emoji) => EmojiIconWidget(
                size: 80,
                onTap: (icon) {
                  bloc.add(HabitEditorChangeIconEvent(icon: icon));
                },
                emoji: emoji,
                isSelected: bloc.habitEntity.icon == emoji))
            .toList(),
      ),
    );
  }
}
