import 'package:flutter/material.dart';
import 'package:habit_tracker/main.dart';

void back() {
  Navigator.pop(context);
}

void push(Widget pageWidget) {
  Navigator.push(
      context, PageRouteBuilder(pageBuilder: (context, a, b) => pageWidget));
}
