import 'package:flutter/material.dart';
import 'package:habit_tracker/main.dart';

void back() {
  Navigator.pop(context);
}

Future<T?> push<T>(Widget pageWidget) async {
  return await Navigator.push(
      context, PageRouteBuilder(pageBuilder: (context, a, b) => pageWidget));
}

// replace
Future<T?> replace<T>(Widget pageWidget) {
  return Navigator.pushReplacement(
      context, PageRouteBuilder(pageBuilder: (context, a, b) => pageWidget));
}
