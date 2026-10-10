import 'package:flutter/material.dart';

abstract final class AppDatePicker {
  static Future<DateTime?> pick(BuildContext context, {DateTime? initialDate}) {
    final now = DateTime.now();

    return showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 10),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF2F817D)),
        ),
        child: child!,
      ),
    );
  }
}
