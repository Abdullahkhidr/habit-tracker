import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';

abstract class TextStyles {
  // Headers Text Styles
  static const TextStyle h1 =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor);
  static const TextStyle h2 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kTextColor);
  static const TextStyle h3 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: kTextColor);
  static const TextStyle h4 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kTextColor);
  static const TextStyle h5 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kTextColor);

  // Body Text Styles
  static TextStyle b1 = const TextStyle(fontSize: 22, color: kTextColor);
  static TextStyle b2 = const TextStyle(fontSize: 19, color: kTextColor);
  static TextStyle b3 =
      TextStyle(fontSize: 17, color: kTextColor.withOpacity(0.9));
  static TextStyle b4 =
      TextStyle(fontSize: 15, color: kTextColor.withOpacity(0.8));
  static TextStyle b5 =
      TextStyle(fontSize: 13, color: kTextColor.withOpacity(0.7));
}
