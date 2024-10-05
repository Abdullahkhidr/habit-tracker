import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class PartOfDayFilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const PartOfDayFilterButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpaceExtraSmall),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: kPaddingExtraSmall,
          foregroundColor: selected ? Colors.white : Colors.black,
          backgroundColor: selected ? kPrimaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(
              color: selected ? Colors.transparent : kHintColor,
              width: 1.w,
            ),
          ),
        ),
        child: Text(label,
            style: TextStyles.b4
                .copyWith(color: selected ? kOnPrimaryColor : kTextColor)),
      ),
    );
  }
}
