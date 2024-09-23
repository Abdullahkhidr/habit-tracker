import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class CustomFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final int? maxLines;
  const CustomFieldWidget({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    required this.hint,
    this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintStyle: TextStyles.b4.copyWith(color: kSecondaryColor),
          hintText: hint,
          prefixIcon: leadingIcon == null ? null : Icon(leadingIcon),
          suffixIcon:
              trailingIcon == null ? null : Icon(trailingIcon, size: 20),
          filled: true,
          fillColor: kHintColor.withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: kBorderRadiusSmall, borderSide: BorderSide.none)),
    );
  }
}
