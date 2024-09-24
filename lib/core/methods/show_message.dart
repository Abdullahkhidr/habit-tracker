import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/main.dart';
import 'package:toastification/toastification.dart';

void showMessage(String message,
    {String description = '', MessageType messageType = MessageType.info}) {
  toastification.show(
    context: context,
    type: switch (messageType) {
      MessageType.success => ToastificationType.success,
      MessageType.error => ToastificationType.error,
      MessageType.info => ToastificationType.info,
      MessageType.warning => ToastificationType.warning,
    },
    style: ToastificationStyle.minimal,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(message, style: TextStyles.h4),
    description:
        description.isEmpty ? null : Text(description, style: TextStyles.b5),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    // icon: const Icon(Icons.check),
    showIcon: true,
    // primaryColor: Colors.green,
    // backgroundColor: Colors.white,
    // foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.always,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: false,
  );
}

enum MessageType {
  success,
  error,
  warning,
  info,
}
