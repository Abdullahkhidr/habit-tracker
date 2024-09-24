import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';

class IconSelectorWidget extends StatelessWidget {
  const IconSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.from(emojis)
            .map((emoji) => EmojiIconWidget(
                onTap: (icon) =>
                    bloc.add(HabitEditorChangeIconEvent(icon: icon)),
                emoji: emoji,
                isSelected: bloc.habitEntity.icon == emoji))
            .toList(),
      ),
    );
  }
}

class EmojiIconWidget extends StatelessWidget {
  final String emoji;
  final bool isSelected;
  final Function(String) onTap;
  const EmojiIconWidget(
      {super.key,
      required this.emoji,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(emoji),
      child: Container(
          margin: kPaddingSmall.copyWith(left: 0),
          padding: kPaddingSmall,
          decoration: BoxDecoration(
              borderRadius: kBorderRadiusSmall,
              border: Border.all(width: isSelected ? 3 : 0.5)),
          child: Text(emoji, style: const TextStyle(fontSize: 50))),
    );
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
