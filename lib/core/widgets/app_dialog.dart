import 'package:flutter/material.dart';
import 'app_button.dart';

abstract final class AppDialog {
  static Future<bool> confirmDelete(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          AppButton(
            label: 'Delete',
            onPressed: () => Navigator.pop(dialogContext, true),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
