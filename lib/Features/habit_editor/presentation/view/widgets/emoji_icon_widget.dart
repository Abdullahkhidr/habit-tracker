import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';

class EmojiIconWidget extends StatelessWidget {
  final String emoji;
  final double size;
  final bool isSelected;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Function(String)? onTap;
  const EmojiIconWidget(
      {super.key,
      required this.emoji,
      this.isSelected = false,
      this.onTap,
      required this.size,
      this.borderWidth,
      this.backgroundColor,
      this.margin,
      this.borderRadius,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap?.call(emoji),
        child: Container(
          height: size,
          width: size,
          margin: margin ?? kPaddingSmall.copyWith(left: 0),
          padding: padding ?? kPaddingSmall,
          decoration: BoxDecoration(
              color: isSelected
                  ? kPrimaryColor
                  : backgroundColor ?? Colors.transparent,
              borderRadius: borderRadius ?? kBorderRadiusSmall,
              border: borderWidth == 0
                  ? null
                  : Border.all(width: isSelected ? 1 : (borderWidth ?? 0.5))),
          child: Image.asset('assets/emojis/$emoji.png'),
        ));
  }
}
