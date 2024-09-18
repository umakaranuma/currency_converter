// confirmation_dialog.dart
import 'package:flutter/material.dart';

class ConfirmationDialog {
  static void show({
    required BuildContext context,
    required VoidCallback onDelete,
    String title = 'Delete Confirmation',
    String content = 'Are you sure you want to delete this currency?',
    String cancelText = 'Cancel',
    String confirmText = 'Yes',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(confirmText),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onDelete(); // Execute delete action
              },
            ),
          ],
        );
      },
    );
  }
}
