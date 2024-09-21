import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/color_item_widget.dart';

class PaletteColorsWidget extends StatelessWidget {
  const PaletteColorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kPaddingSmall.vertical),
        child: Wrap(
            spacing: kPaddingSmall.horizontal,
            runSpacing: kPaddingSmall.vertical,
            children: List.generate(_paletteColors.length,
                (index) => ColorItemWidget(color: _paletteColors[index]))),
      ),
    );
  }
}

const _paletteColors = [
  Color(0xFFF2C464),
  Color(0xFFFFA07A),
  Color(0xFF786C3B),
  Color(0xFFC9C4B5),
  Color(0xFFFFC0CB),
  Color(0xFFFFB6C1),
  Color(0xFFFF69B4),
  Color(0xFFFFC5C5),
  Color(0xFFC7B8EA),
  Color(0xFFC5C3C5),
  Color(0xFFADD8E6),
  Color(0xFF4682B4),
  Color(0xFF87CEEB),
  Color(0xFFC6E2B5),
  Color(0xFFE2B5B5),
];
