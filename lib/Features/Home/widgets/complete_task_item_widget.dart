import 'package:flutter/material.dart';

class CompleteTaskItemWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const CompleteTaskItemWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(label),
        trailing: Icon(icon, color: Colors.green),
      ),
    );
  }
}
